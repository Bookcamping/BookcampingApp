class Notification < ActiveRecord::Base
  belongs_to :user
  belongs_to :version

  validates_presence_of :user_id, :version_id
  validates_uniqueness_of :version_id, scope: :user_id
end
