module DashboardHelper
  def comma_delimited_blog_links
    blogs = Blog.all
    if blogs.count.zero?
      " -- Uh oh! I don't seem to have any blogs after all!!"
    elsif blogs.count == 1
      link_to blogs.first.title, blog_posts_path(blogs.first)
    else
      links = blogs[0..-2].map { |b| link_to b.title, blog_posts_path(b) }.join(", ")
      links + ", and " + link_to(blogs.last.title, blog_posts_path(blogs.last))
    end
  end
end
