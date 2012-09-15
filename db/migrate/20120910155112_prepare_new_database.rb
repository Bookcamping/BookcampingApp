# encoding: utf-8
class PrepareNewDatabase < ActiveRecord::Migration
  def up
    # USERS
    add_column :users, :versions_count, :integer, default: 0
    execute "update users set versions_count=(select count(*) from versions where whodunnit=cast(users.id AS TEXT))"
    execute "update versions set item_type='Reference' where item_type='Book'"
    execute "update versions set item_type='Shelf' where item_type='BookList'"

    add_column :users, :admin, :boolean, default: false
    User.where('rol is not null').update_all(admin: true)
    remove_column :users, :rol


    # SHELVES
    execute "update shelves set camp_id=6 where type='UserShelf'"
    remove_column :shelves, :type

    # LIBRARIES
    rename_table :camps, :libraries
    [:comments, :references, :shelf_items, :shelves, :versions].each do |table|
      rename_column table, :camp_id, :library_id
    end
    add_column :libraries, :open, :boolean, default: true
    add_column :libraries, :last_activity_email_at, :datetime
    Library.update_all(last_activity_email_at: Time.now)
    add_column :libraries, :icon_path, :string, limit: 100
    Library.update_all(icon_path: 'logos/bookcamping.png')
    add_column :libraries, :shelf_name, :string, limit: 100
    Library.update_all(shelf_name: 'estantería')
    add_column :libraries, :description, :text

    drop_table :media_bites
    drop_table :posts
    drop_table :publishers

  end

  def down
  end
end
