class AddUserReferencesCount < ActiveRecord::Migration
  def up
    add_column :users, :references_count, :integer, default: 0
    add_column :users, :subscriptions_count, :integer, default: 0

    User.reset_column_information
    User.find_each do |user|
      User.reset_counters user.id, :references
      User.reset_counters user.id, :subscriptions
    end
  end

  def down
    remove_column :users, :references_count
    remove_column :users, :subscriptions_count
  end
end
