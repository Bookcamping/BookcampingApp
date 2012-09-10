# Library: a collection of shelves
class Library < ActiveRecord::Base
  has_many :shelves
  has_many :memberships, as: :resource
  has_many :members, through: :memberships, class_name: 'User', source: :user

  extend FriendlyId
  friendly_id :slug

  store :settings, accessors: [:description]
end
