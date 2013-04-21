module HasFollowers
  extend ActiveSupport::Concern

  included do
    has_many :followings, as: :followed,
      dependent: :delete_all, 
      order: 'created_at DESC'
    has_many :followers, through: :followings,
      source: :user, class_name: 'User'

    after_create do
      add_follower(self.user)
    end
  end

  def add_follower(user)
    following_for(user) || Following.create!(user: user, followed: self)
  end

  def following_for(user)
    Following.where(followed_id: self.id,
                    followed_type: self.class.name,
                    user_id: user.id).first
  end
end
