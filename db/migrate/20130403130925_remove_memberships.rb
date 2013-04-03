class RemoveMemberships < ActiveRecord::Migration
  def up
    drop_table :memberships
    User.where(id: [1, 2, 20, 455, 284, 546, 6, 1505]).update_all(admin: true)
    remove_column :users, :rol
    remove_column :users, :site_member
    remove_column :users, :group
    remove_column :users, :memberships_count
    add_column :users, :watcher, :boolean, default: false
  end

  def down
    create_table "memberships", :force => true do |t|
      t.integer "library_id"
      t.integer "user_id"
    end
    add_column :users, :rol, :string, limit: 10
    add_column :users, :site_member, :boolean, default: false
    add_column :users, :group, :boolean, default: false
    add_column :users, :memberships_count, :integer
  end
end
