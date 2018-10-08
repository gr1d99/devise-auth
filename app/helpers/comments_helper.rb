# frozen_string_literal: true

module CommentsHelper
  include ApplicationHelper

  EDIT_DISPLAY_CONTENT = "<small><span><i class='fas fa-pen'></i></span></small>"
  DELETE_DISPLAY_CONTENT = "<small><span class='danger'><i class='fas fa-trash'></i></span></small>"

  def edit_comment_link_for(comment)
    return nil unless owner?(comment)

    post = comment.commentable
    link_to(edit_post_comment_path(post, comment), class: 'edit-comment-link') do
      EDIT_DISPLAY_CONTENT.html_safe
    end
  end

  def delete_comment_link_for(comment)
    return nil unless owner?(comment)

    post = comment.commentable
    link_to(post_comment_path(post, comment),method: :delete, class: 'delete-comment-link') do
      DELETE_DISPLAY_CONTENT.html_safe
    end
  end
end
