class AddTimestampsDateToShelfItems < ActiveRecord::Migration
  def change
    ShelfItem.where('created_at IS NULL').each do |item|
      date = item.reference.created_at
      date ||= 1.year.ago
      item.update_attribute(:created_at, date)
    end
  end
end
