# Library: a collection of shelves
class Library < ActiveRecord::Base
  has_many :shelves, order: 'updated_at DESC'
  belongs_to :user
  has_many :versions
  include HasMembers

  extend FriendlyId
  friendly_id :slug

  LTYPES = ['camping', 'guides', 'publisher']

  validates_presence_of :user_id, :name, :slug

  def guides?
    self.ltype == 'guides'
  end
end
