class OnlineStatusBrodcastJob < ApplicationJob
  queue_as :default

  def perform(user, action)
    following_users_channels = get_followers_channels("appearances_channel", user)
    
    if following_users_channels.present?
      ActionCable.server.broadcast_multiple following_users_channels, set_content(user, action)
    end
  end
  
  private
  def set_content(user, action)
    content = {}
    content["user"] = {}
    
    if action == "online"
      content["user"]["content"] =  ApplicationController.renderer.render(partial: 'layouts/newsfeed/sidebar_left/online_user', locals: { online_user: user})
      content["user"]["user_id"] = user.id
      content["status"] = "online"
    elsif action == "offline"
      content["user"]["user_id"] = user.id
      content["status"] = "offline"
    end
    
    return content
  end
end
