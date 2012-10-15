class AddKeysToVersion < ActiveRecord::Migration
  def change
    add_column :versions, :reference_id, :integer
    remove_column :versions, :extra

    add_index :versions, :reference_id
    add_index :versions, :event
    add_index :versions, :item_type
  end
end
