class CoverBackToReference < ActiveRecord::Migration
  def up
    add_column :references, :cover_image, :string, limit: 400
    Download.where('cover_image IS NOT NULL').each do |download|
      download.reference.update_column(:cover_image, download.cover_image)
    end
    remove_column :downloads, :cover_image
    remove_column :downloads, :description
  end

  def down
    remove_column :references, :cover_image
    add_column :downloads, :cover_image, :string, limit: 400
    add_column :downloads, :description, :text
  end
end
