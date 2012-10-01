class AddEmailNotificationsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :email_notifications, :boolean, default: true

    PaperTrail.enabled = false
    User.find(490).destroy
    User.find(1811).destroy
  end
end
