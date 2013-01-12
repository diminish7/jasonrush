module ApplicationHelper

  def get_title(include_post=true)
    if @blog
      "Jason Rush: #{@blog.name.titleize}" + (@post && include_post ? " - #{@post.title}" : "")
    else
      "Jason Rush"
    end
  end

  def pretty_month_and_year(month, year)
    "#{Date::MONTHNAMES[month.to_i]} #{year}"
  end

  # URL For current page including full domain
  def here
    params = { host: request.host, protocol: request.protocol }
    params[:port] = request.port if request.port != 80
    url_for(params)
  end

end
