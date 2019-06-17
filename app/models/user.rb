# frozen_string_literal: true

class User < ApplicationRecord
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

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
end
