module Api
class MicropostsController < BaseController
  before_action :auth_only!
  
  def index
    # @microposts =  Micropost.all.paginate(:page => params[:page], :per_page => 5)
    @microposts = Micropost.all.ordered.includes(:user, :likes)
    # render json: @microposts.to_json(:methods => [:image_url])
    @send_microposts = []
    current_user_id = current_user.id
    @microposts.each do |m|
      micropost = {
        id: m.id, 
        user_id: m.user_id,
        title: m.title,
        street: m.street,
        number: m.number,
        city: m.city,
        content: m.description,
        likers_count: m.likers_count,
        latitude: m.latitude.to_f.to_s,
        longitude: m.longitude.to_f.to_s,
        picture: m.picture.large.url,
        user_click_like: ((m.likes.collect(&:liker_id) & [current_user_id]).size > 0).to_s
      }
      @send_microposts << micropost
    end
    render json: @send_microposts
  end
  
  def create
    params[:micropost].merge!({user_id: current_user.id})
    @micropost =  Micropost.new(micropost_params)
    if @micropost.save
      micropost = {
        id: @micropost.id, 
        user_id: @micropost.user_id,
        title: @micropost.title,
        street: @micropost.street,
        number: @micropost.number,
        city: @micropost.city,
        content: @micropost.description,
        likers_count: @micropost.likers_count,
        latitude: @micropost.latitude,
        longitude: @micropost.longitude,
        picture: @micropost.picture.url,
        user_click_like: "false"
      }
      # comentariu
      render json: micropost
    else
      render json:@micropost.errors, status: :unprocessable_entity
    end
  end
  
  def like_unlike
    @micropost = Micropost.where(id: params[:id]).first
    if @micropost.present?
      if !current_user.likes?(@micropost)
        current_user.like!(@micropost)
        render json: {message: "OK", action: "like"}
      else
        current_user.unlike!(@micropost)
        render json: {message: "OK", action: "unlike"}
      end
    else
      render json: {message: "ERROR"}
    end
  end
  
  def update
    @micropost = Micropost.where(id: params[:id]).first
    if @micropost.update_attributes(micropost_params)
      micropost = {
        id: @micropost.id, 
        user_id: @micropost.user_id,
        title: @micropost.title,
        street: @micropost.street,
        number: @micropost.number,
        city: @micropost.city,
        content: @micropost.description,
        likers_count: @micropost.likers_count,
        latitude: @micropost.latitude,
        longitude: @micropost.longitude,
        picture: @micropost.picture.url
      }
      render json: micropost
    else
      render json: @micropost.error, status: :unprocessable_entity
    end
  end
  
  def new
    @micropost = Micropost.new
    render json: @micropost
  end
  
  def destroy
    @micropost = Micropost.where(id: params[:id]).first
    if current_user.id == @micropost.user_id
      Micropost.destroy(params[:id])
      render json: {message: "OK"}
    else
      render json: {message: "ERROR"}, status: :unprocessable_entity
    end
  end
  
  protected
  def micropost_params
    params.require(:micropost).permit( :title, :description, :street, :number, :city, :user_id, :picture, :latitude, :longitude)
  end
end
end
