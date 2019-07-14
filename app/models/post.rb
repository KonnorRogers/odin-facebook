class Post < ApplicationRecord
  belongs_to :author, class_name: "User"

  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :content, presence: true,
                      length: { maximum: 140 }
end
