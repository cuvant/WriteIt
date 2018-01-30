class ApplicationJob < ActiveJob::Base
  
  protected
  def get_followers_channels(channel, user)
    channels = []
    followers_ids = user.followers_user_ids
    
    followers_ids.each do |id|
      channels << "#{channel}_#{id}"
    end
    
    return channels
  end
end
