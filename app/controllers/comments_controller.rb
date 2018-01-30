class CommentsController < InheritedResources::Base
  before_action :authenticate_user!
  before_action :load_micropost
  before_action :load_comment, except: [:index, :new]
  load_and_authorize_resource
  
  def edit
  end
  
  def index
    @comments = @micropost.comments.includes(:user).order("created_at ASC")

    respond_to do |format|
      format.html { render layout: !request.xhr? }
    end
  end
  
  def show
  end
  
  def new
    @comment = Comment.new(micropost_id: @micropost.id, user_id: current_user.id)
  end
  
  def create
    params[:comment].merge!({user_id: current_user.id})
    params[:comment].merge!({micropost_id: params[:micropost_id]})
    @comment = Comment.new(comment_params)
    
    @result = @comment.save_with_hooks?
    
    flash[:error] = @comment.errors.full_messages.to_sentence if @result == false
    
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
  end
  
  def update
    @comment.update(comment_params)
    redirect_to micropost_path(@micropost)
  end
  
  def destroy
    @comment.destroy!
    
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
  end
  
  def delete_comment
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:content, :micropost_id, :user_id)
    end
    
    def load_micropost
      @micropost = Micropost.where(id: params[:micropost_id]).first
      authorize! :read, @micropost
    end
    
    def load_comment
      @comment = Comment.find_by(id: params[:id])
    end
end
