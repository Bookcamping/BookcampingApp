class CreateReviews < ActiveRecord::Migration
  def up
    create_table :reviews do |t|
      t.belongs_to :reference
      t.belongs_to :user
      t.text :body
      t.timestamps
    end
    add_index :reviews, :reference_id
    add_index :reviews, :user_id

    add_column :references, :reviews_count, :integer, default: 0

    remove_column :shelf_items, :mark
    remove_column :shelf_items, :library_id

    PaperTrail.enabled = false
    ActiveRecord::Base.record_timestamps = false

    visit = Shelf.find 4927
    visit.shelf_items.each do |item|
      body = item.reference.description
      item.update_attribute(:description, body)
      item.reference.update_attribute(:description, '')
    end
  end

  def down
    drop_table :reviews

    remove_column :references, :reviews_count

    add_column :shelf_items, :mark, :string, limit: 32
    add_column :shelf_items, :library_id, :integer
  end
end
