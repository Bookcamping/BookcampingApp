class CreateFollowings < ActiveRecord::Migration
  def change
    ActiveRecord::Base.record_timestamps = false
    create_table :followings do |t|
      t.integer :user_id
      t.integer :followed_id
      t.string :followed_type, limit: 32
      t.datetime :created_at
    end

    add_index :followings, :user_id
    add_index :followings, [:followed_id, :followed_type]

    add_column :shelves, :followers_count, :integer, default: 0
    add_column :libraries, :followers_count, :integer, default: 0

    Subscription.find_each do |subscription|
      Following.create!(user: subscription.user,
                       followed: subscription.shelf,
                       created_at: subscription.created_at)
    end
  end
end
