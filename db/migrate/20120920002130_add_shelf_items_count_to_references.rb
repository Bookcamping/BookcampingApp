class AddShelfItemsCountToReferences < ActiveRecord::Migration
  def up
    add_column :references, :shelf_items_count, :integer, default: 0
    ActiveRecord::Base.record_timestamps = false
    Reference.all.each do |ref|
      ref.update_attribute(:shelf_items_count, ref.shelf_items.count)
    end
  end

  def down
    remove_column :references, :shelf_items_count, :integer, default: 0
  end
end
