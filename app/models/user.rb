class User < ActiveRecord::Base
  has_many :references, dependent: :restrict
  #has_many :comments, dependent: :destroy
  has_many :shelves, dependent: :restrict
  has_many :subscriptions
  has_many :subscribed, through: :subscriptions, source: :shelf
  has_many :memberships, dependent: :destroy
  has_many :libraries, through: :memberships

  validates :name, presence: true, uniqueness: true
  validates :email, uniqueness:true, presence: true

  extend FriendlyId
  friendly_id :name, use: :slugged
  include Identifiable

  def self.current=(user)
    Thread.current[:user] = user
  end

  def audit_login
    self.last_login_at = Time.now
    self.login_count ||= 0
    self.login_count = self.login_count + 1
    self.save(:validate => false)
  end
end
