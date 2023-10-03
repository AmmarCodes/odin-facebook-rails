class CreateFriendshipsTable < ActiveRecord::Migration[6.1]
  def change
    create_table :friendships do |t|
      t.integer :user_id
      t.integer :friend_id
      t.boolean :confirmed, default: false
      t.timestamps
    end

    add_index(:friendships, %I[user_id friend_id], unique: true)
    add_index(:friendships, %I[friend_id user_id], unique: true)
  end
end
