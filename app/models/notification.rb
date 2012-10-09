class Notification < ActiveRecord::Base
  belongs_to :user
  belongs_to :version

  validates_presence_of :user_id, :version_id
  validates_uniqueness_of :version_id, scope: :user_id

  def self.find_or_create(attributes)
    Notification.where(user_id: attributes[:user_id],
                       version_id: attributes[:version_id]).first || 
                       Notification.create(attributes)
  end
end
