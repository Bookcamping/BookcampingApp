class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.belongs_to :shelf
      t.belongs_to :user
      t.datetime :created_at
    end
    add_index :subscriptions, :shelf_id
    add_index :subscriptions, :user_id
    add_column :shelves, :subscriptions_count, :integer, default: 0

    PaperTrail.enabled = false
    Shelf.all.each do |shelf| 
      shelf.add_subscriber(shelf.user)
    end

  end
end
