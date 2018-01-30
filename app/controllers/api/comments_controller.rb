module Api
class CommentsController < BaseController
  before_action :auth_only!
  
  def index
    @comments = Comment.where(micropost_id: params[:micropost_id]).includes(:user)
    @send_comments = []
    @comments.each do |c|
      comment = {
        id: c.id,
        user_id: c.user_id,
        micropost_id: c.micropost_id,
        content: c.content,
        user_name: c.user.user_name
      }
      @send_comments << comment
    end
    render json: @send_comments
  end
  
  def destroy
    @comment = Comment.where(id: params[:id]).first
    if current_user.id == @comment.user_id
      Comment.destroy(params[:id])
      render json: { message: "OK" }
    else
      render json: {message: "ERROR"}, status: :unprocessable_entity
    end
  end
  
  def update
    @comment = Comment.where(id: params[:id]).first
    if @comment.update_attributes(comment_params)
      comment = {
        id: @comment.id,
        user_id: @comment.user_id,
        micropost_id: @comment.micropost_id,
        content: @comment.content,
        user_name: @comment.user.user_name
      }
      render json: comment
    else
      render json: @comment.error, status: :unprocessable_entity
    end
  end
  
  def create
    params[:comment].merge!({user_id: current_user.id})
    params[:comment].merge!({micropost_id: params[:micropost_id]})
    @comment = Comment.new(comment_params)
    if @comment.save
      comment = {
        id: @comment.id,
        user_id: @comment.user_id,
        micropost_id: @comment.micropost_id,
        content: @comment.content,
        user_name: @comment.user.user_name,
      }
      render json: comment
    else
      render json:@micropost.errors, status: :unprocessable_entity
    end
  end
  
  def new
    @comment = Comment.new
    render json: @comment
  end
  
  protected 
  
  def comment_params
    params.require(:comment).permit( :user_id, :micropost_id, :content, :user_name )
  end
  
end
end
