# frozen_string_literal: true

class User < ApplicationRecord
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


  def self.genders
    %i[male female other]
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
