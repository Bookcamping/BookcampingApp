class CleanShelvesOptions < ActiveRecord::Migration
  def up
    remove_column :shelves, :open
    remove_column :shelves, :hidden
    remove_column :shelves, :settings
    remove_column :shelves, :shelf_members_count
    remove_column :shelves, :comments_count
    remove_column :shelves, :group_id

    add_column :shelves, :visualization, :string, limit: 10
    add_column :shelves, :protected, :boolean, default: false
  end

  def down
    add_column :shelves, :open, :boolean, default: true
    add_column :shelves, :hidden, :boolean, default: false
    add_column :shelves, :settings, :string
    add_column :shelves, :shelf_members_count, :integer
    add_column :shelves, :comments_count, :integer
    add_column :shelves, :group_id, :integer

    remove_column :shelves, :visualization
    remove_column :shelves, :protected
  end
end
