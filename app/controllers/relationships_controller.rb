class RelationshipsController < ApplicationController

  def follow_user
    @user = User.where(user_name: params[:user_name]).first
    
    if @user.present? && current_user.follow(@user.id)
      followers_count unless params[:newsfeed].present?
      @is_online = check_online
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js
      end
    end
  end

  def unfollow_user
    @user = User.where(user_name: params[:user_name]).first
    
    if @user.present? && current_user.unfollow(@user.id)
      followers_count unless params[:newsfeed].present?
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js
      end
    end
  end
  
  private
  def followers_count
    @followers_count = @user.followers.count
  end
  
  def check_online
    return @user.is_online?
  end
end
