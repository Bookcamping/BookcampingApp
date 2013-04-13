class ShelfItemNotifier
  include Sidekiq::Worker

  def perform(shelf_item_id, action)
    item = ShelfItem.find(shelf_item_id)
    User.where(watcher: true).each do |user|
      NotifyMailer.shelf_item_created(item, user)
    end
  end
end
