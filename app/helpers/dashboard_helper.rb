module DashboardHelper
  def dev_blog
    @dev_blog ||= Blog.where(name: "dev").first
  end

  def writing_blog
    @writing_blog ||= Blog.where(name: "writing").first
  end
end
