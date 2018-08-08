class PostsController < ApplicationController
  before_action :authenticate_user!

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
      :description
    )
  end
end
