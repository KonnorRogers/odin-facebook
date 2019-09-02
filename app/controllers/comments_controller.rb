class CommentsController < ApplicationController
  before_action :set_commentable

  def create
    @comment = @commentable.comments.create(user: current_user)

    respond_to do |fmt|
      fmt.html { redirect_to @comment }
      fmt.js
    end
  end

  def destroy
    @comment = Comment.where(user_id: current_user.id).find(params[:id])
    @comment.destroy

    respond_to do |fmt|
      fmt.html { redirect_to @commentable }
      fmt.js
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :user_id, :commentable_id)
  end

  def set_commentable
    @commentable = if params[:comment_id]
                     Comment.find(params[:comment_id])
                   elsif params[:post_id]
                     Post.find(params[:post_id])
                   end
  end
end
