# Library: a collection of shelves
class Library < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug

  has_many :shelves
  store :settings, accessors: [:description]
end
