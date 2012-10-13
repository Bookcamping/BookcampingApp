class VersionObserver < ActiveRecord::Observer
  def after_create(version)
    version.update_attribute(:activity, Activity.activity?(version))

    if version.item_type == 'ShelfItem'
      version.shelf.subscriptors.each do |user|
        if user != version.user
          send_email = user.send_email?
          Notification.find_or_create(user_id: user.id,
                                      version_id: version.id,
                                      mail_pending: send_email)
        end
      end
    end
  end
end
