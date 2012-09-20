class CacheShelfItemsCount < ActiveRecord::Migration
  def up
    execute "update references set shelf_items_count=(select count(*) from shelf_items where reference_id=references.id)"
  end

  def down
  end
end
