class CacheShelfItemsCount < ActiveRecord::Migration
  def up
    ActiveRecord::Base.record_timestamps = false
    Reference.reset_column_information
    Reference.find_each do |ref|
      Reference.reset_counters ref.id, :shelf_items
    end
  end

  def down
  end
end
