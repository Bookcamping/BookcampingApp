class Notifier 
  include Sidekiq::Worker

  def perform(model, action, id, options = {})
    action = action.to_s.sub(/e?$/, "ed")
    self.send("#{model}_#{action}", id, options)
  end

  private
  def test_email_created(id, options) 
    User.where(watcher: true).each do |user|
      NotifyMailer.test_email(user)
    end
  end

  def shelf_created(shelf_id, options)
    shelf = Shelf.find(shelf_id)
    User.where(watcher: true).each do |user|
      NotifyMailer.shelf_created(shelf, user)
    end
  end

  def shelf_item_created(shelf_item_id, options)
    item = ShelfItem.find(shelf_item_id)
    User.where(watcher: true).each do |user|
      NotifyMailer.shelf_item_created(item, user)
    end
  end
end
