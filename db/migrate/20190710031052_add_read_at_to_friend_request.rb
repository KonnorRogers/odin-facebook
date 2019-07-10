class AddReadAtToFriendRequest < ActiveRecord::Migration[5.2]
  def change
    add_column :friend_requests, :read_at, :datetime
  end
end
