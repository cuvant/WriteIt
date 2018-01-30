class Notification < ApplicationRecord
  belongs_to :user
  has_many :following_relationships, through: :user
  belongs_to :notified_by, class_name: 'User'
  
  belongs_to :micropost
  belongs_to :comment
  belongs_to :follow
  belongs_to :mention
  
  validates :user_id, :notified_by_id, :notice_type, presence: true
  
  # returns all notifications from a user, ordered, called from notifications#index
  scope :ordered, -> (user_id) { where.not(notified_by_id: user_id).order(created_at: :desc) }
  
  # returns the most 5 unread notifications a user has, called from notifications#index
  # used to display the most recent 5 notifications a user has when he clicks
  # on notifications dropdown in the navbar
  scope :ordered_js, -> (user_id) { where.not(notified_by_id: user_id).where(read: false).order(created_at: :desc).limit(5) }
  
  # returns how many unread notifications a user has, called from _notifications_dropdown.html.haml
  # used to display undread notifcations count in navbar
  scope :navbar_count, -> (user_id) { where.not(notified_by_id: user_id).where(read: false).count }
  
  # returns array of notifications types, ex: [comment, follow, like] (limit 4), called from users#show
  # from this array we display on users#show the activity's a user did
  scope :activities, -> (user_id) { where(notified_by_id: user_id).where.not(user_id: user_id).order(created_at: :desc).limit(4).pluck(:notice_type, :created_at) }
  
  
  # Performing NotificationBroadcastJob to stream notifications
  # and all the informations needed when creating a notifications
  after_create_commit { NotificationBroadcastJob.perform_later(self) }
  after_destroy_commit { NotificationBroadcastJob.perform_now(self, "false") }

end
