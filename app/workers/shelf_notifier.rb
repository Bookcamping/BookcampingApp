class ShelfNotifier 
  include Sidekiq::Worker

  def perform(shelf_id, action)
    shelf = Shelf.find(shelf_id)
    User.where(watcher: true).each do |user|
      NotifyMailer.shelf_created(shelf, user)
    end
  end
end
