# frozen_string_literal: true

class User < ApplicationRecord
  # Handles when a user REQUESTS another user
  has_many :friend_requests, dependent: :destroy
  has_many :sent_requests, through: :friend_requests, source: :friend

  # Handles when a user was REQUESTED BY another user
  has_many :inverse_friend_requests, class_name: 'FriendRequest',
                                     foreign_key: 'friend_id',
                                     dependent: :destroy
  has_many :received_requests, through: :inverse_friend_requests, source: :user

  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  has_many :inverse_friendships, class_name: 'Friendship',
                                 foreign_key: 'friend_id',
                                 dependent: :destroy
  has_many :inverse_friends, through: :inverse_friendships, source: :user

  GENDERS = %i[male female other].freeze

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         authentication_keys: [:email]

  VALID_NAME_REGEXP = /\A[A-Za-z]+\z/.freeze

  %i[first_name last_name].each do |attr|
    validates attr, presence: true,
                    length: { maximum: 50 },
                    format: { with: VALID_NAME_REGEXP }
  end

  validates :birthday, presence: true,
                       age: { too_young: 13, too_old: 120 }

  validates :gender, presence: true,
                     inclusion: {
                       in: GENDERS.map(&:to_s),
                       message: '%{value} is not a valid gender'
                     }

  def full_name
    "#{first_name} #{last_name}"
  end

  def friend?(friend)
    all_frineds.include?(friend)
  end

  def pending_request?(friend)
    all_friend_requests.include?(friend)
  end

  def all_friends
    friends + inverse_friends
  end

  def all_friend_requests
    received_requests + sent_requests
  end
end
