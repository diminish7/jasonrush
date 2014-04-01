module PostsHelper
  def posts_angular_url(blog)
    root_url + "#/blogs/#{blog.to_param}/posts"
  end

  def post_angular_url(post)
    posts_angular_url(post.blog) + "/#{post.to_param}"
  end
end