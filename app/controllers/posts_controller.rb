class PostsController < ApplicationController
  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      flash.now[:success] = "Post created"
      redirect_to root_url
    else
      flash.now[:error] = "Post did not submit"
      render 'users/index'
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end
end
