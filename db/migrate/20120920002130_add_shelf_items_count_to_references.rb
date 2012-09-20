class AddShelfItemsCountToReferences < ActiveRecord::Migration
  def up
    add_column :references, :shelf_items_count, :integer, default: 0
  end

  def down
    remove_column :references, :shelf_items_count, :integer, default: 0
  end
end
