class AddTagsToShelves < ActiveRecord::Migration
  def change
    add_column :shelves, :taggings_count, :integer, default: 0

    rename_column :taggings, :reference_id, :tagged_id
    add_column :taggings, :tagged_type, :string, limit: 32

    Tagging.update_all(tagged_type: 'Reference')
  end
end
