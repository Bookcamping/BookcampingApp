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
    ActiveRecord::Base.record_timestamps = false
    Shelf.reorder('updated_at ASC').each do |shelf|
      Subscription.create(shelf: shelf, user: shelf.user, created_at: shelf.created_at)
    end
  end
end
