class PostsController < ApplicationController
  before_action :authenticate_user!, only: %i[index new create show edit update destroy]

  def index
    @posts = current_user.posts.all
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
    @post = post
  end

  def update
    post.update_attributes(post_params)
    redirect_to post_path(post), notice: :'Post updated successfully'
  end

  def destroy
    post.destroy
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
    current_user.posts.find(params[:id])
  end
end
