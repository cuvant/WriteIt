class Comment < ApplicationRecord

  belongs_to :micropost
  belongs_to :user
  has_one :notification, dependent: :destroy
  validates :content, presence: true, length: { maximum: 200 }
  
  after_create_commit { MicropostBrodcastJob.perform_later(self, "comment", "true", self.user_id) }
  after_destroy_commit { MicropostBrodcastJob.perform_now(self, "comment", "false", self.user_id) }
  
  after_destroy :destroy_mentions_notifications
  
  acts_as_mentioner
  include MentionConcernUtilities

  #TODO research:
  # 1. Should we generate HTML in model?
  # 2. Is a good idea to check first for mentions in comment then save it?
  def save_with_hooks?
    modified_content, user_names = check_for_mentionable(self)
    self.content = modified_content if user_names.present?
    
    if self.save
      # if @names present than we have mentions
      # create mentions and notifications
      # else just create notification for the comment
      if user_names.present?
        create_mentions(user_names, self)
      else
        Notification.create(user_id: micropost.user_id, notified_by_id: user_id, micropost_id: micropost.id, comment_id: id, notice_type: "comment")
      end
      
      return true
    else
      return false
    end
  end
  
  private

  def destroy_mentions_notifications
    user_ids = self.mentionees(User).map(&:id)
    Notification.where(read: false, notice_type: "mention", user_id: user_ids, comment_id: self.id).destroy_all if user_ids.present?
  end

end
