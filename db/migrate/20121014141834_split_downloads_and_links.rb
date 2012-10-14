class SplitDownloadsAndLinks < ActiveRecord::Migration
  def change
    drop_table :downloads

    create_table :links do |t|
      t.belongs_to :user
      t.belongs_to :reference
      t.string :url, limit: 300
      t.string :description, limit: 100
      t.string :host, limit: 100
      t.string :mime_type, limit: 16
      t.integer :position
      t.timestamps
    end
    add_index :links, :reference_id
    add_index :links, :user_id
#   add_column :references, :downloads_count, :integer, default: 0

    create_table :downloads do |t|
      t.belongs_to :user
      t.belongs_to :reference
      t.string :file, limit: 300
      t.integer :file_size
      t.string :content_type
      t.integer :position
      t.timestamps
    end
    add_index :downloads, :reference_id
    add_index :downloads, :user_id

    add_column :references, :links_count, :integer, default: 0

  end
end
