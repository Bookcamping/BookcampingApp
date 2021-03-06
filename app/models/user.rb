require 'texticle/searchable'

class User < ActiveRecord::Base
  has_many :references, dependent: :restrict
  # has_many :comments, dependent: :destroy
  has_many :shelves, dependent: :restrict
  has_many :versions
  has_many :activity, class_name: 'Version',
                      foreign_key: 'user_id', conditions: { activity: true }

  include HasRecommendations

  has_many :followings
  has_many :followed_shelves, through: :followings,
                              source: :followed, source_type: 'Shelf'

  validates :name, uniqueness: true, presence: true
  validates :email, uniqueness: true, presence: true

  mount_uploader :avatar, AvatarUploader

  extend Searchable(:name)
  extend FriendlyId
  friendly_id :name, use: :slugged
  include Identifiable

  def self.current=(user)
    Thread.current[:user] = user
  end

  def self.current
    Thread.current[:user]
  end

  def send_email?
    if email_pending
      true
    elsif email.present? && email_notifications?
      update_attribute(:email_pending, true)
      true
    end
  end

  def audit_login
    self.last_login_at = Time.now
    self.login_count ||= 0
    self.login_count = self.login_count + 1
    save(validate: false) # <- Esto es así porque las cuentas viejas no tienen email puesto
  end
end
