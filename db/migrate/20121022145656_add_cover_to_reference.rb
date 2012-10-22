class AddCoverToReference < ActiveRecord::Migration
  def up
    add_column :references, :cover, :string, limit: 350
    add_column :references, :taggings_count, :integer, default: 0
    PaperTrail.without_versioning do
      Reference.find_each do |reference|
        Reference.reset_counters reference.id, :taggings
        Reference.reset_counters reference.id, :downloads
      end
    end
  end

  def down
    remove_column :references, :cover
    remove_column :references, :taggings_count
  end
end
