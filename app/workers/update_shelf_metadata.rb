class UpdateShelfMetadata
  include Sidekiq::Worker

  def perform(shelf_id)
    shelf = Shelf.find(shelf_id)
    shelf.editors.destroy_all
    shelf.shelf_items.find_each do |item|
      Editor.edit(item.shelf, item.user) if item.shelf && item.user
    end
  end

end
