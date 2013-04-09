class ShelfNotifier 
  include Sidekiq::Worker

  def perform(shelf_id, action = :create)
    shelf = Shelf.find(shelf_id)
    User.where(watcher: true).each do |user|
      UserMailer.shelf_created(shelf, user)
    end
  end
end
