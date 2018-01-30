class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_user, only: [:show]
  load_and_authorize_resource
  layout "timeline"
  
  def show
    @microposts = @user.displayed_microposts(params[:page] || "1")
    @activities = @user.activities
    
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def index
    @users = User.paginate(page: params[:page])
  end

  def edit
    @user = current_user
  end

  def update
    prepare_params
    if @user.update_attributes(user_params)
      flash[:success] = "Successfully updated!"
      redirect_to profile_path(@user.user_name)
    else
      @user.reload
      render 'edit'
    end
  end
  
  def get_following
    following = @user.following_user_names
    respond_to do |format|
      format.js { render :json => following }
    end
  end
  
  def get_followers
    @users = @user.followers
  end
  
  def all_users
    @users = User.all
  end

  private
    def user_params
      params.require(:user).permit( :email, :password, :password_confirmation, :image, :remove_image, :user_name, :first_name, :last_name, :bio, :timeline_cover, :user_name)
    end

    def load_user
      if params[:id].present?
        @user = User.where(id: params[:id]).first
      else
        @user = User.where(user_name: params[:user_name]).first
      end
      redirect_to root_path and return if @user.blank?
    end

    def prepare_params
      if params[:user][:password].blank? && \
        params[:user][:password_confirmation].blank?
        params[:user].delete(:password)
        params[:user].delete(:password_confirmation)
      end
    end

end
