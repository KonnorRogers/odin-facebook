# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'

  has_many :likes, as: :likeable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy

  validates :content, presence: true,
                      length: { maximum: 140 }

  default_scope -> { order(created_at: :desc) }
end
