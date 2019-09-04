# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  def index
    if user_signed_in?
      @post = current_user.posts.build
      @feed = current_user.feed.paginate(page: params[:page], per_page: 2)
    else
      redirect_to signup_path
    end
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      flash[:success] = 'Post successfully created'
      redirect_to root_url
    else
      flash[:error] = 'Post did not submit'
      render 'new'
    end
  end

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(post_params)
      flash[:success] = 'Post updated'
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    Post.find(params[:id]).destroy
    flash[:success] = 'Post deleted'
    redirect_to root_url
  end

  def show
    @post = Post.find(params[:id])
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end
end
