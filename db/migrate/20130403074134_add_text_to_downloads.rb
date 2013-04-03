class AddTextToDownloads < ActiveRecord::Migration
  def change
    rename_column :downloads, :description, :name
    add_column :downloads, :description, :text
  end
end
