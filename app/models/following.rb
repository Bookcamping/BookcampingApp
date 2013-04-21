class Following < ActiveRecord::Base
  belongs_to :user
  belongs_to :followed, polymorphic: true, counter_cache: :followers_count

  validates_presence_of :user_id, :followed_id, :followed_type
end
