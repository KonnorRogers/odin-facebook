# https://dev.to/lucysuddenly/nested-comments-in-ruby-on-rails-1k1f
class Comment < ApplicationRecord
  belongs_to :user
  # Is the parent of the comment
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable

  validates :content, presence: true,
                      length: { maximum: 140 }

  default_scope -> { order(created_at: :desc) }

  def destroy
    update(user: nil, content: nil)
  end

  # Count is accesssed via comments_count which is a colum in Post
  after_create :increment_count
  after_destroy :decrement_count

  def increment_count
    parent = commentable

    # Keep looping until we get to the parent which isn't a Comment model
    parent = parent.commentable while parent.is_a? Comment
    parent.increment! :comments_count
  end

  def decrement_count
    parent = commentable

    # Keep looping until we get to the parent which isn't a Comment model
    parent = parent.commentable while parent.is_a? Comment
    parent.decrement! :comments_count
  end
end
