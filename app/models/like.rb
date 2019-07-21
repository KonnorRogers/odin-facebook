class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  # Validates that the user has only liked the post 1 time
  validates :user, uniqueness: { scope: :post }
end
