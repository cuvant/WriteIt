class AppearanceChannel < ApplicationCable::Channel
  def subscribed
    # Not sure if we can use this redis variable in a job
    # Jobs run in different threads
    
    stream_from("appearances_channel_#{current_user.id}")
    $redis_onlines.set("#{current_user.id}", "online")
    OnlineStatusBrodcastJob.perform_later(current_user, "online")
  end
  
  def unsubscribed
    $redis_onlines.del("#{current_user.id}")
    OnlineStatusBrodcastJob.perform_later(current_user, "offline")
  end
end
