class Like < ApplicationRecord
  belongs_to :user
  belongs_to :likeable, polymorphic: true

  # Validates that the user has only liked the post 1 time
  # https://github.com/gorails-screencasts/gorails-24-liking-posts/blob/master/
  validates :user, uniqueness: { scope: :likeable }
end
