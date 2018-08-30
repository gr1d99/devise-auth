module PostsHelper
  def owner?(post)
    return false if current_user.nil?
    post.user.email.eql?(current_user.email)
  end
end
