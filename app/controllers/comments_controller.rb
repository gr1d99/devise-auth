# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update destroy]
  before_action :set_post, only: %i[create new edit update destroy]
  before_action :set_comment, only: %i[edit update destroy]

  def new; end

  def create
    comment = @post.comments.new(comment_params.merge(user_id: current_user.id))
    if comment.save
      redirect_to post_path(@post), notice: 'Comment added'
    else
      render 'new'
    end
  end

  def edit; end

  def update
    @comment.update_attributes(comment_params)
    redirect_to post_path(@post), notice: 'Comment updated'
  end

  def destroy
    @comment.destroy
    redirect_to post_path(@post), notice: 'Comment deleted'
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end

  def set_post
    @post = Post.find_by!(id: params[:post_id], user: current_user)
  end

  def set_comment
    @comment = @post.comments.find_by!(id: params[:id], user: current_user)
  end
end
