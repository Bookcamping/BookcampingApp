class CleanDownloadsAndLinks < ActiveRecord::Migration
  def up
    add_column :downloads, :description, :string, limit: 100
    remove_column :downloads, :user_id
    remove_column :links, :user_id
    drop_table :repubs
    remove_column :references, :repubbed
  end

  def down
    add_column :downloads, :user_id, :integer
    add_column :links, :user_id, :integer
    remove_column :downloads, :description

    create_table :repubs do |t|
      t.belongs_to :reference
      t.string :content_type, limit: 8
      t.text :body
      t.timestamps
    end
    add_index :repubs, :reference_id

    add_column :references, :repubbed, :boolean, default: false
  end
end
