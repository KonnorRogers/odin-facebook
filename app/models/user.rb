# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # may not be needed due to devise
  # VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze

  # validates :email, presence: true,
  #                   length: { maximum: 255 },
  #                   format: { with: VALID_EMAIL_REGEX },
  #                   uniqueness: { case_sensitive: false }

  VALID_NAME_REGEXP = /\A[A-Za-z]+\z/.freeze
  %i[first_name last_name].each do |attr|
    validates attr, presence: true,
                    length: { maximum: 50 },
                    format: { with: VALID_NAME_REGEXP }
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
