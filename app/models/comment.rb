class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable

  validates :content, presence: true,
                      length: { maximum: 140 }

  default_scope -> { order(created_at: :desc) }
end
