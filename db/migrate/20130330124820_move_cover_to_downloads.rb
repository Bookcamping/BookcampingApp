class MoveCoverToDownloads < ActiveRecord::Migration
  def up
    ActiveRecord::Base.record_timestamps = false

    add_column :downloads, :cover_image, :string, limit: 400

    Reference.where('cover IS NOT NULL').each do |ref|
      cover_image = ref.cover
      ref.downloads.each do |download|
        puts "Ref #{ref.title} - Download #{download.id}: #{cover_image}"
        download.update_column(:cover_image, cover_image)
      end
    end
    remove_column :references, :cover_image
    remove_column :references, :cover
  end

  def down
    add_column :references, :cover, :string, limit: 350
    add_column :references, :cover_image, :string, limit: 300
    remove_column :downloads, :cover_image
  end
end
