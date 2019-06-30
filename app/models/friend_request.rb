# frozen_string_literal: true

class FriendRequest < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  validates :user, presence: true
  validates :friend, presence: true, uniqueness: { scope: :user }

  validate :not_self
  validate :not_friends
  validate :not_pending

  private

  def not_self
    errors.add(:friend, "can't be equal to user") if user == friend
  end

  def not_friends
    errors.add(:friend, 'is already added') if user.friend?(friend)
  end

  def not_pending
    return unless user.pending_request?(friend)

    errors.add(:friend, 'already requested friendship')
  end
end
