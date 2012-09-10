class PrepareNewDatabase < ActiveRecord::Migration
  def up
    execute "update shelves set camp_id=6 where type='UserShelf'"
    remove_column :shelves, :type

    rename_table :camps, :libraries
    [:comments, :references, :shelf_items, :shelves, :versions].each do |table|
      rename_column table, :camp_id, :library_id
    end

    drop_table :media_bites
    drop_table :posts
  end

  def down
  end
end
