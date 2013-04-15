class UpdateShelfMetadata
  include Sidekiq::Worker

  def perform(shelf_id)
    shelf = Shelf.find(shelf_id)
    shelf.editors.destroy_all
    shelf.shelf_items.find_each do |item|
      Editor.edit(item.shelf, item.user) if item.shelf && item.user
    end

    shelf.taggings.destroy_all
    shelf.references.where('tag_names IS NOT NULL').find_each do |reference|
      reference.tag_names.split(',').each do |tag_name|
        shelf.add_tag(tag_name)
      end
    end
  end

end
