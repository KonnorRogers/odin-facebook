class CreateFriendRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :friend_requests do |t|
      t.integer :user_id, foreign_key: true
      t.integer :friend_id

      t.timestamps
    end

    add_index :friend_requests, :user_id
    add_index :friend_requests, :friend_id
    add_index :friend_requests, %i[user_id friend_id], unique: true
  end
end
