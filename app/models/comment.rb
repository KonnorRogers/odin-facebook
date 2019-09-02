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
end
