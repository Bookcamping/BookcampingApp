# Library: a collection of shelves
class Library < ActiveRecord::Base
  has_many :shelves, order: 'updated_at DESC'
  belongs_to :user
  include HasMembers

  extend FriendlyId
  friendly_id :slug

  store :settings, accessors: [:description]
  
  validates_presence_of :user_id
end
