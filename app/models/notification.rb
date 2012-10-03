class Notification < ActiveRecord::Base
  belongs_to :user
  belongs_to :activity

  validates_presence_of :user_id, :activity_id
  validates_uniqueness_of :activity_id, scope: :user_id
end
