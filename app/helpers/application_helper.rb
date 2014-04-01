module ApplicationHelper

  def get_title(include_post=true)
    if @blog
      "Jason Rush: #{@blog.name.titleize}" + (@post && include_post ? " - #{@post.title}" : "")
    else
      "Jason Rush"
    end
  end

end
