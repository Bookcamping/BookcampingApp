class RemoveUnusedShelfItems < ActiveRecord::Migration
  def up
    PaperTrail.enabled = false
    ShelfItem.find_each do |item|
      item.destroy if item.reference.blank?
    end
  end

  def down
  end
end
