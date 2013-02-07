class AddShelfOrderToLibrary < ActiveRecord::Migration
  def up
    add_column :libraries, :fixed_shelf_order, :boolean, default: false
    remove_column :libraries, :show_media_on_lists
  end

  def down
    remove_column :libraries, :fixed_shelf_order
    add_column :libraries, :show_media_on_lists, default: false
  end
end
