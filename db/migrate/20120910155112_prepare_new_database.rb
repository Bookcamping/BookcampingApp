class PrepareNewDatabase < ActiveRecord::Migration
  def up
    add_column :users, :versions_count, :integer, default: 0
    execute "update users set versions_count=(select count(*) from versions where whodunnit=cast(users.id AS TEXT))"
    execute "update versions set item_type='Reference' where item_type='Book'"
    execute "update versions set item_type='Shelf' where item_type='BookList'"


    execute "update shelves set camp_id=6 where type='UserShelf'"
    remove_column :shelves, :type

    rename_table :camps, :libraries
    [:comments, :references, :shelf_items, :shelves, :versions].each do |table|
      rename_column table, :camp_id, :library_id
    end

    add_column :libraries, :description, :text
    add_column :libraries, :shelf_name, :string, limit: 100

    drop_table :media_bites
    drop_table :posts
    drop_table :publishers

  end

  def down
  end
end
