class CreateDownloads < ActiveRecord::Migration
  def change
    create_table :downloads do |t|
      t.belongs_to :reference
      t.string :url, limit: 300
      t.string :file, limit: 300
      t.string :description, limit: 100
      t.integer :position
      t.timestamps
    end
    add_index :downloads, :reference_id

    add_column :references, :downloads_count, :integer, default: 0
  end
end
