class MicropostBrodcastJob < ApplicationJob
  queue_as :default

  # type can be "like" / "comment" /
  def perform(record, type, remove = "true", user_id = nil)
    ActionCable.server.broadcast "micropost:#{get_micropost_id(record, type)}",  set_values(record, type, remove, user_id)
  end
  
  def set_values(record, type, remove, user_id)
    content = {
      "notice_type": type,
      "remove": remove,
      "user_id": user_id.to_s
    }

    case type
    when "like"

      content["like"] = {}
      content["like"]["partial"] = ApplicationController.renderer.render(partial: 'microposts/likes', locals: { micropost: record })
      content["like"]["micropost_id"] = record.id

    when "comment"

      content["comment"] = {}

      # remove == false, means the callback is when a notification is destroyed
      # that means a comment/like/follow is destroyed
      if remove == "false"
        content["comment"]["partial"] = record.id
      else
        content["comment"]["partial"] = ApplicationController.renderer.render(partial: 'comments/comment', locals: {comment: record, micropost: record.micropost})
      end

      content["comment"]["micropost_id"] = record.micropost_id

    end

    return content
  end
  
  def get_micropost_id(record, type)
    return record.id if type == "like"
    return record.micropost_id # type == "comment"
  end
end
