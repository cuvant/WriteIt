class MicropostChannel < ApplicationCable::Channel
  def subscribed
    # stop_all_streams
    stream_from "micropost:#{params['micropost_id'].to_i}"
  end

  def unsubscribed
    # stop_all_streams
  end
  
  def someone_is_writing
    ActionCable.server.broadcast "micropost:#{params['micropost_id'].to_i}", {commenting: params['micropost_id'].to_i, notice_type: "commenting", user_id: current_user.id.to_s}
  end
end
