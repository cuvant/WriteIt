class MicropostsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_micropost, except: [:create, :index, :search, :new, :browse]
  load_and_authorize_resource
  respond_to :html, :js
  layout "newsfeed"
  
  
  def index
    # @micropost = Micropost.new
    # if params[:user_id].present?
    #   @user = User.find_by(id: params[:user_id])
    #   @microposts = Micropost.includes(:user, comments: :user).where(user_id: params[:user_id].to_i).ordered.includes(:user)
    # else
    #   # @user = current_user
    #   user_ids = [current_user.id] + current_user.following_ids
    #   @microposts = Micropost.of_followed_users(user_ids).includes(:user, comments: :user).paginate(page: page.to_i, per_page: 3)
    # end
    @microposts = Micropost.all.displayed(params[:page] || "1")
    @follow_recomandations = current_user.follow_recomandations
    
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def show  
    # @comments = @micropost.comments
    # @comment = Comment.new(micropost_id: @micropost.id, user_id: current_user.id)
    # @can_delete_comments = {}
    # @comments.each do |c|
    #   @can_delete_comments[c.id] = can?(:destroy, c)
    # end
    # @can_like = Like.where(liker_id: current_user.id, likeable_id: @micropost.id).try(:size) == 0
    # @locations = Micropost.near([@micropost.latitude, @micropost.longitude], 10, order: "distance")
    # @location = nil
    # if @locations.present?
    #   @location = @locations.select do |location|
    #     location.id == @micropost.id
    #   end.first
    # end
  end

  def new
    @micropost = Micropost.new
  end

  def create
    @micropost = current_user.microposts.new(micropost_params)
    if @micropost.save
      flash[:success] = "Micropost created!"
      respond_to do |format|
        format.html { redirect_to microposts_path }
        format.js
      end
    else
      redirect_to new_micropost_path
    end
  end
  
  def update
    if @micropost.update_attributes(micropost_params)
      redirect_to microposts_path
    else
      render 'edit'
    end
  end
  
  def destroy
    @micropost.destroy
    flash[:success] = "Micropost deleted!"
    redirect_to microposts_path
  end

  def like
    current_user.try_like(@micropost)
    @micropost.reload
    
    respond_to do |format|
      format.html { redirect_to microposts_path }
      format.js
    end
  end
  
  def unlike
    current_user.try_unlike(@micropost)
    @micropost.reload
    
    respond_to do |format|
      format.html { redirect_to microposts_path }
      format.js
    end
  end

  def search
    if params[:search].present?
      @microposts = Micropost.search(params[:search])
    else
      @microposts = Micropost.all
    end
    
    @can_delete_microposts = {}
    @microposts.each do |m|
      @can_delete_microposts[m.id] = can?(:manage, m)
    end
  end
  
  def edit
  end
  
  def static_map
    @locations = Micropost.near([@micropost.latitude, @micropost.longitude], 10, order: "distance").where.not(id: @micropost.id)
    
    respond_to do |format|
      format.html { redirect_to microposts_path }
      format.js
    end
  end
  
  def browse
    page = params[:page] || "1"
    @microposts = Micropost.all.ordered.paginate(page: page.to_i, per_page: 3)
    user_permissions

    respond_to do |format|
      format.html
      format.js
    end
  end

  private

  def load_micropost
    @micropost = Micropost.where(id: params[:id]).first
    @user = @micropost.user
  end

  def micropost_params
    params.require(:micropost).permit( :title, :description, :street, :number, :city, :picture, :likers_count )
  end

end
