module ApplicationHelper

  def nav_is_active(item)
    posib = {}
    
    posib["timeline"] = ["users#show"]
    # add here possibilities
    
    possibilities = posib[item]
    if possibilities.present?
      if possibilities.any? { |pos| pos == "#{params[:controller]}##{params[:action]}"}
        return "active"
      end
    end
    
    return ""
  end

  def add_error(message, status)
    if status == "error"
      flash.now[:error] = message if message.present?
    elsif status == "success"
      flash.now[:success] = message if message.present?
    else
      flash.now[:notice] = message if message.present?
    end
  end
  
  def alert_for(flash_type)
  {
    success: 'alert-success text-center',
    error: 'alert-danger text-center',
    alert: 'alert-warning text-center',
    notice: 'alert-info text-center'
  }[flash_type.to_sym] || flash_type.to_s
  end
  
  # Returns the full title on a per-page basis.
  def full_title(page_title = '')
    base_title = "WriteIt"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end
  
  def profile_avatar_select(user)  
  return image_tag user.image.url(:medium),
                   id: 'image-preview',
                   class: 'img-responsive img-circle profile-image' if user.image.present?
  image_tag 'fallback/user.gif', id: 'image-preview',
                                  class: 'img-responsive img-circle profile-image'
end  
end
