module ProfileHelper
  
  def display_activity(type)
    case type
    when "like"
      return "Liked a Post"
    when "comment", "mention"
      return "Commented on a Post"
    when "follow"
      return "Started following a User"
    end
  end
end
