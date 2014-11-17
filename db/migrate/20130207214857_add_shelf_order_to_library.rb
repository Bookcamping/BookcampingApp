class AddShelfOrderToLibrary < ActiveRecord::Migration
  def up
    add_column :libraries, :, :boolean, default: false
    remove_column :libraries, :show_media_on_lists
  end

  def down
    remove_column :libraries, :
    add_column :libraries, :show_media_on_lists, default: false
  end
end
