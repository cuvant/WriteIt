module MentionConcernUtilities
  extend ActiveSupport::Concern
  include Rails.application.routes.url_helpers
  include ActionView::Helpers::UrlHelper
  
  def check_for_mentionable(resource)
    if resource.is_a?(Comment)
      content = resource.content.split
    elsif resource.is_a?(Micropost)
      content = resource.description.split
    end

    return change_content(content, resource.user)
  end
  
  def change_content(content, user)
    user_names = []
    followers = user.following.pluck(:user_name)
    
    content.each_with_index do |word, index|
      if word.starts_with?("@")
        user_name = word.gsub(/^./, "")
        
        if followers.include?(user_name)
          user_names << user_name
          content[index] = "#{(link_to word, profile_path(user_name)).html_safe}"
        end
      end
    end
    
    return content.join(" "), user_names
  end
  
  def create_mentions(user_names, resource)
    users = User.where(user_name: user_names)
    mentions = []
    users.each do |u|
      mention = Mention.new(mentioner_type: resource.class.name, mentioner_id: resource.id, mentionable_type: "User", mentionable_id: u.id)
      if mention.save
        if resource.is_a?(Comment)
          micropost_id = resource.micropost_id
          comment_id = resource.id
        else
          micropost_id = micropost.id
          comment_id = nil
        end
        Notification.create(user_id: u.id, notified_by_id: resource.user_id, micropost_id: micropost_id, comment_id: comment_id, mention_id: mention.id, notice_type: "mention" )
      end
    end
  end
end
