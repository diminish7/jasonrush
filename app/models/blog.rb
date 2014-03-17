class Blog < ActiveRecord::Base
  has_many :posts, dependent: :destroy

  has_friendly_id :name, use_slug: true

  attr_accessible :name, :description

  def title
    self.name.titleize
  end

  # Return a hash of the months, by year for all posts of this blog
  def possible_years_and_months
    @possible_years_and_months ||= Post.select("DISTINCT(YEAR(created_at)) as year").where("blog_id = ?", self.id).inject({}) do |years, year_post|
      years[year_post.year] = Post.select("DISTINCT(MONTH(created_at)) as month")
                                  .where("blog_id = ? AND YEAR(created_at) = ?", self.id, year_post.year)
                                  .order("month")
                                  .collect { |month_post| month_post.month }
      years
    end
  end

  def as_simple_json
    {
      id: id,
      name: name,
      title: title
    }
  end
end
