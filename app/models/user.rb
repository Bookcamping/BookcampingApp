class User < ActiveRecord::Base
  has_many :references, dependent: :restrict
  #has_many :comments, dependent: :destroy
  has_many :shelves, dependent: :restrict
  has_many :subscriptions
  has_many :subscribed, through: :subscriptions, source: :shelf
  has_many :memberships, dependent: :destroy
  has_many :libraries, through: :memberships
  has_many :recommendations, dependent: :destroy
  has_many :versions
  has_many :notifications

  validates :name, uniqueness: true, presence: true
  validates :email, uniqueness:true, presence: true

  extend FriendlyId
  friendly_id :name, use: :slugged
  include Identifiable

  def self.current=(user)
    Thread.current[:user] = user
  end

  def self.current
    Thread.current[:user]
  end

  def recommendation(reference)
    Recommendation.where(user_id: self.id, 
                         reference_id: reference.id).first
  end

  def recommend(reference)
    r = Recommendation.new(user_id: self.id, 
                           reference_id: reference.id)
    r.save ? r : nil
  end

  def unrecommend(reference)
    recommendation(reference).try(:destroy)
  end

  def audit_login
    self.last_login_at = Time.now
    self.login_count ||= 0
    self.login_count = self.login_count + 1
    self.save(:validate => false)
  end
end
