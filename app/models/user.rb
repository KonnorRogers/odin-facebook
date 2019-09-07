# frozen_string_literal: true

class User < ApplicationRecord
  ####### Friendship Related relationships
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
  ####### END Friendship Related relationships

  has_many :notifications, foreign_key: 'recipient_id', dependent: :destroy
  has_many :posts, foreign_key: 'author_id', dependent: :destroy
  has_many :likes, through: :posts
  has_many :comments, through: :posts

  GENDERS = %i[male female other].freeze

  # Include default devise modules. Others available are:
  #  :lockable, :timeoutable, :trackable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable,
         authentication_keys: [:email]

  devise :omniauthable, omniauth_providers: %i[facebook]

  %i[first_name last_name].each do |attr|
    validates attr, presence: true,
                    length: { maximum: 50 }
  end

  ### NO LONGER VALIDATING DUE TO OMNIAUTH ISSUES
  # validates :birthday, presence: true,
                       # age: { too_young: 13, too_old: 120 }

  # validates :gender, presence: true,
  #                    inclusion: {
  #                      in: GENDERS.map(&:to_s),
  #                      message: '%{value} is not a valid gender'
  #                    }
  ### NO LONGER VALIDATING DUE TO OMNIAUTH ISSUES

  # OMNIAUTH stuff
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      # If you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def all_friends
    friends + inverse_friends
  end

  def all_friend_requests
    received_requests + sent_requests
  end

  def feed
    ids = all_friends.pluck(:id) << id
    Post.where(author_id: ids)
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def friend?(friend)
    all_friends.include?(friend)
  end

  def pending_request?(friend)
    all_friend_requests.include?(friend)
  end

  def likes?(post)
    post.likes.where(user_id: id).any?
  end

  protected

  # def confirmation_required?
  #   false
  # end
end
