class Following < ActiveRecord::Base
  belongs_to :user, counter_cache: :followers_count
  belongs_to :follower, class_name: 'User', counter_cache: :follows_count
  has_many :versions, as: :item, dependent: :delete_all

  validates_presence_of :user_id, :follower_id
  
  has_paper_trail on: [:create], meta: {
    title: :followed_name
  }

  def followed_name
    user.name
  end
end
