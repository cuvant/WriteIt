class NotificationsController < ApplicationController
  # before_filter :authenticate_user!
  # authorize_resource only: [:link_through, :index]
  layout "newsfeed"
  
  def link_through
    @notification = Notification.find(params[:id])
    @notification.update(read: true)
    
    if @notification.follow_id.present?
      redirect_to profile_path(@notification.notified_by.user_name)
    else
      redirect_to micropost_path @notification.micropost
    end
  end
  
  def index
    respond_to do |format|
      format.html{
        @notifications = current_user.notifications.ordered(current_user.id)
        current_user.notifications.update_all(read: true)
      }
      format.js{
        @notifications = current_user.notifications.ordered_js(current_user.id)
      }
    end
  end
end
