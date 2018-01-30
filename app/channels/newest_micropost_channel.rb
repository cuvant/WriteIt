class NewestMicropostChannel < ApplicationCable::Channel
  def subscribed
    stream_from "news_channel_#{current_user.id}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
  
  def set_image
    
  end
end
