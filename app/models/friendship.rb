# frozen_string_literal: true

class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  validates :user, presence: true
  validates :friend, presence: true, uniqueness: { scope: :user }
  validate :not_self


  private

  def not_self
    errors.add(:friend, "can't be equal to user") if user == friend
  end
end
