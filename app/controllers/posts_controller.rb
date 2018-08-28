class PostsController < ApplicationController
  before_action :authenticate_user!, only: %i[index new create show]

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
      redirect_to new_post_path, notice: 'Post created successfully'
    else
      render 'new'
    end
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
