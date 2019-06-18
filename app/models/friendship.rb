class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class: "User"
end
