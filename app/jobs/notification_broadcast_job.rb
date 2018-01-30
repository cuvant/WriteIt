class NotificationBroadcastJob < ApplicationJob
  queue_as :default

  def perform(notification, use_sound = "true")
    if notification.user_id != notification.notified_by_id
      ActionCable.server.broadcast "notification_channel_#{notification.user_id}",  set_values(notification, use_sound)
    end
  end
  
  private
  # if self_action is present and is "true" that means
  # a user commented / liked his own micropost
  # and we brodcast information to his following users only
  def set_values(notification, use_sound)
    content = {
      "notice_type": notification.notice_type,
      "use_sound": use_sound
    }

    case notification.notice_type
    when "follow"
      
      content["follow"] = {}
      content["follow"]["followers_count"] = Follow.where(following_id: notification.user_id).count
      content["follow"]["user_id"] = notification.user_id
    end

    content["counter"] = Notification.where(user_id: notification.user_id, read: false).where.not(notified_by_id: notification.user_id).count
    
    return content
  end

end
