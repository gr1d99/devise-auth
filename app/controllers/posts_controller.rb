class PostsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update destroy]

  def index
    @posts = Post.all
  end

  def show
    @post = post
  end

  def new
    @post = current_user.posts.new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to post_path(@post), notice: 'Post created successfully'
    else
      render 'new'
    end
  end

  def edit
    @post = current_user_post
  end

  def update
    current_user_post.update_attributes(post_params)
    redirect_to post_path(post), notice: :'Post updated successfully'
  end

  def destroy
    current_user_post.destroy
    redirect_to posts_path, notice: :'Post deleted successfully'
  end

  private

  def post_params
    params.require(:post).permit(
      :title,
      :content
    )
  end

  def post
    Post.find(params[:id])
  end

  def current_user_post
    current_user.posts.find(params[:id])
  end
end
