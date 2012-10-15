module HasFollowings
  extend ActiveSupport::Concern

  included do
    has_many :followings
    has_many :followers, :through => :followings

    has_many :followeds, :class_name => "Following",
      :foreign_key => "follower_id"
    has_many :follows, :through => :followeds,
      :source => :user

  end

  def following(user)
    return nil if user.blank?
    Following.where(follower_id: self.id, user_id: user.id).first
  end

  def follow(user)
    return nil if user.blank?
    Following.create!(follower_id: self.id, user_id: user.id)
  end
end
