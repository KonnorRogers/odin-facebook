class CommentsController < ApplicationController
  before_action :set_commentable

  def create
    @comment = @commentable.comments.create(user: current_user)
  end

  def destroy
  end

  def edit
  end

  def update
  end

  def show
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :user_id, :commentable_id)
  end

  def set_post
    if params[:post_id]
      @commentable = Post.find(params[:post_id])
    elsif params[:comment_id]
      @commentable = Comment.find(params[:comment_id]
    end
  end
end
