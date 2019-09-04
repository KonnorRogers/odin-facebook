class CommentsController < ApplicationController
  before_action :set_commentable

  def create
    @comment = @commentable.comments.build(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      flash[:success] = "Your comment was posted successfully!"
    else
      flash[:danger] = "Your comment was not posted successfully"
    end

    redirect_back(fallback_location: root_path)
  end

  def destroy
    @comment = Comment.where(user_id: current_user.id).find(params[:id])
    @comment.destroy

    redirect_back(fallback_location: root_path)
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id)
  end

  def set_commentable
    @commentable = if params[:comment_id]
                     Comment.find_by(id: params[:comment_id])
                   elsif params[:post_id]
                     Post.find_by(id: params[:post_id])
                   end
  end
end
