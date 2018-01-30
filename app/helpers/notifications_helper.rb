module NotificationsHelper
  def display_notification(notification)
    return link_to "#{display_text(notification)} #{time_ago_in_words(notification.created_at)} ago.", link_through_path(notification)
  end
  
  def display_text(notification)
    text = "#{notification.notified_by.user_name} has "
    
    case notification.notice_type
    when "follow"
      "#{text} started following you"
    when "comment"
      "#{text} commented on your post"
    when "like"
      "#{text} liked your post"
    when "mention"
      "#{text} mentioned you in a #{notification.comment_id.present? ? "comment" : "micropost" }"
    end
  end
end
