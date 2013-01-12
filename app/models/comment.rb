class Comment < ActiveRecord::Base
  belongs_to :commentable, polymorphic: true

  validates_presence_of :comment, :commentable

  attr_accessible :email, :name, :comment, :commentable_id, :commentable_type, :commentable

  scope :active, lambda { where("active = ?", true) }

  def can_edit?(user)
    self.commentable.can_edit?(user) rescue false
  end

  def name_or_anonymous
    self.name.blank? ? "Anonymous" : self.name
  end

  # Split up the comment text by line breaks so we can wrap those in paragraph tags
  def chunks
    self.comment.split("\n")
  end

protected
  def notify_author
    CommentMailer.new_comment_email(self).deliver
  end
end
