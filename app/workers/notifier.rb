class Notifier 
  include Sidekiq::Worker

  def perform(model, action, id, options = {})
    action = action.to_s.sub(/e?$/, "ed")
    self.send("#{model}_#{action}", id, options)
  end

  private
  def shelf_created(shelf_id, options)
    shelf = Shelf.find(shelf_id)
    subscribers do |user|
      NotifyMailer.shelf_created(shelf, user).deliver
    end
  end

  def shelf_item_created(shelf_item_id, options)
    item = ShelfItem.find(shelf_item_id)
    item.shelf.followers.each do |user|
      NotifyMailer.shelf_item_created(item, user).deliver if user.email?
    end
  end

  def reference_updated(reference_id, options)
    reference = Reference.find(reference_id)
    subscribers do |user|
      NotifyMailer.reference_updated(reference, user).deliver
    end
  end

  def subscribers
    User.where(watcher: true).all.each do |user|
      yield(user)
    end
  end
end
