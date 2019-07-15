class PostsController < ApplicationController
  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      flash[:success] = "Post successfully created"
    else
      flash[:error] = "Post did not submit"
    end

    # redirect_to root_url
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def show

  end

  private

  def post_params
    params.require(:post).permit(:content)
  end
end
