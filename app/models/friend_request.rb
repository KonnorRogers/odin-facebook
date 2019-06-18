# frozen_string_literal: true

class FriendRequest < ApplicationRecord
  after_create :create_inverse_relationship
  after_destroy :destroy_inverse_relationship

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

  def create_inverse_relationship
    friend.friend_requests.create(friend: user)
  end

  def destroy_inverse_relationship
    friend_request = friend.friend_requests.find_by(friend: user)
    friend_request&.destroy
  end
end
