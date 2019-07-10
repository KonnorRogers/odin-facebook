# frozen_string_literal: true

class FriendRequest < ApplicationRecord
  # after_save :send_friend_request_notification

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

  # def send_notification
  #   Notification.create(recipient: friend, sender: user,
  #                       action: 'sent', notifiable: self)
  # end
end
