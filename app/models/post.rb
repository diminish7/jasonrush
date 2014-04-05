class Post < ActiveRecord::Base
  belongs_to :blog
  belongs_to :author, class_name: "User"

  has_many :comments, as: :commentable, dependent: :destroy, order: "created_at"

  attr_accessible :title, :body, :author, :author_id, :blog, :blog_id, :cached_slug

  has_friendly_id :title, use_slug: true, scope: "blog_id"

  before_save :populate_summary

  scope :recent, lambda {
    ordered.limit(10)
  }
  scope :for_month, lambda { |month|
    where("MONTH(created_at) = ?", month)
  }
  scope :for_year, lambda { |year|
    where("YEAR(created_at) = ?", year)
  }
  scope :ordered, lambda { order("created_at DESC") }

  validates_presence_of :title, :body, :author

  def can_edit?(user)
    user.is_a?(User) && self.author == user
  end

  # Create a default post about how there are no posts
  def self.no_posts(blog, author)
    post = Post.new
    post.blog = blog
    post.author = author
    post.title = "Nothing to See Here!"
    post.created_at = Time.zone.now
    post.updated_at = Time.zone.now
    post.body = "Uh oh! Looks like I haven't actually posted anything to this blog yet! Hopefully I'll get to it pretty soon... (Fingers crossed!)"
    post
  end

  def as_json(*attrs)
    super(*attrs).merge(
      author_name: author.full_name,
      author_first_name: author.first_name,
      slug: to_param
    )
  end

protected
  def populate_summary
    # Only want to do this if we have a body to generate the
    # summary from, and if the summary hasn't already been generated
    return if body.blank? || summary.present?
    doc = Nokogiri::HTML::DocumentFragment.parse(body)
    self.summary = if doc.children.length == 1
      doc.to_html
    else
      doc.children.first.to_html
    end
  end
end
