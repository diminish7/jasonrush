class Blog < ActiveRecord::Base
  has_many :posts, dependent: :destroy

  has_friendly_id :name, use_slug: true

  attr_accessible :name, :description

  def title
    self.name.titleize
  end

  def possible_months
    sql = <<-SQL
      SELECT DISTINCT YEAR(created_at) AS year, MONTH(created_at) AS month, DATE_FORMAT(created_at, '%M') AS month_name
      FROM posts
      WHERE blog_id = #{self.id}
      ORDER BY year DESC, month DESC
    SQL
    connection.select_all(sql)
  end

  def as_json(*args)
    super(*args).merge(title: title)
  end

  def as_simple_json
    {
      id: id,
      name: name,
      title: title
    }
  end
end
