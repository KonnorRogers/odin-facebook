# frozen_string_literal: true

class Friendship < ApplicationRecord
  after_create :destroy_friend_request

  belongs_to :user
  belongs_to :friend, class_name: 'User'

  validates :user, presence: true
  validates :friend, presence: true, uniqueness: { scope: :user }
  validate :not_self

  private

  def not_self
    errors.add(:friend, "can't be equal to user") if user == friend
  end

  def destroy_friend_request
    ids = FriendRequest.where(user_id: user.id, friend_id: friend.id).or(
      FriendRequest.where(user_id: friend.id, friend_id: user.id)
    ).pluck(:id)

    FriendRequest.destroy(ids)
  end
end
