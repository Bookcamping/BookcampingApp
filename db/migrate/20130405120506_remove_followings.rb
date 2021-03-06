class RemoveFollowings < ActiveRecord::Migration
  def up
    drop_table :followings

    remove_column :users, :followers_count
    remove_column :users, :follows_count
  end

  def down
    create_table :followings do |t|
      t.integer :user_id
      t.integer :follower_id
      t.datetime :created_at
    end
    add_index :followings, :user_id
    add_index :followings, :follower_id

    add_column :users, :followers_count, :integer, default: 0
    add_column :users, :follows_count, :integer, default: 0
  end
end
