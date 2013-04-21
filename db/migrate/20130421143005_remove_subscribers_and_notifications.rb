class RemoveSubscribersAndNotifications < ActiveRecord::Migration
  def up
    drop_table :subscriptions
    drop_table :notifications
    remove_column :shelves, :subscriptions_count
    remove_column :users, :subscriptions_count
  end

  def down
  end
end
