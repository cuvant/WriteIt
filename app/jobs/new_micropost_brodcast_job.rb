class NewMicropostBrodcastJob < ApplicationJob
  queue_as :default

  def perform(micropost, step)
    
    if step == "first"
      following_users_channels = get_followers_channels("news_channel", micropost.user)
      
      if following_users_channels.present?
        ActionCable.server.broadcast_multiple following_users_channels, set_content(micropost, step)
      end
    elsif step == "second"
      
    end
  end
  
  private
  
  def set_content(micropost, step)
    content = {}
    
    if step == "first"
      content["micropost"] = ApplicationController.renderer.render(partial: 'microposts/micropost', locals: { micropost: micropost })
      content["user_id"] = micropost.user_id
      content["micropost_id"] = micropost.id
      content["step"] = step
    elsif step == "second"
      
    end
    
    return content
  end
end
