class RemoveLinks < ActiveRecord::Migration
  def change
    ActiveRecord::Base.record_timestamps = false
    add_column :references, :url1, :text
    add_column :references, :url2, :text
    add_column :references, :url3, :text

    Link.find_each do |link|
      link.reference.update_column("url#{link.position}", link.url)
    end

    remove_column :references, :links_count
    drop_table :links
  end
end
