class Shelf < ActiveRecord::Base
  belongs_to :library
  belongs_to :user
  has_many :shelf_items, order: 'created_at ASC'
  has_many :references, through: :shelf_items

  extend FriendlyId
  friendly_id :slug

end
