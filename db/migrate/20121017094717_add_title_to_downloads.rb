class AddTitleToDownloads < ActiveRecord::Migration
  def change
    add_column :downloads, :title, :string, limit: 200
    add_column :downloads, :download_count, :integer, default: 0
    add_index :downloads, :title
  end
end
