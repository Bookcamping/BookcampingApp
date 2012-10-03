class VersionObserver < ActiveRecord::Observer
  def after_create(version)
    version.update_attribute(:activity, false) if version.event == 'update'

    if version.item_type == 'ShelfItem'
      version.shelf.subscriptors.each do |user|
        send_email = user.send_email?
        Notification.create(user: user, version: version, 
                           mail_pending: send_email)
      end
    end
  end
end
