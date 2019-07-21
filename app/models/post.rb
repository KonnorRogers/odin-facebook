class Post < ApplicationRecord
  belongs_to :author, class_name: "User"

  belongs_to :likable, polymorphic: true
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :content, presence: true,
                      length: { maximum: 140 }

  default_scope -> { order(created_at: :desc) }
end
