class CreateEditors < ActiveRecord::Migration
  def change
    create_table :editors do |t|
      t.integer :editable_id
      t.string :editable_type
      t.integer :user_id
      t.integer :count, default: 0
      t.timestamps
    end
    add_index :editors, [:editable_id, :editable_type]
    add_index :editors, :user_id

    add_shelf_editors
  end

  def add_shelf_editors
    ShelfItem.find_each do |item|
      Editor.edit(item.shelf, item.user) if item.shelf && item.user
    end
  end
end
