# frozen_string_literal: true

class FriendRequest < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  validates :user, presence: true
  validates :friend, presence: true, uniqueness: { scope: :user }

  def accept
    user.friends << friend
    destroy
  end

  private

  def not_friends
    errors.add(:friend, 'is already added') if user.friends.include?(friend)
  end

  def not_pending
    return unless friend.pending_friends.include?(user)

    errors.add(:friend, 'friendship still pending')
  end
end
