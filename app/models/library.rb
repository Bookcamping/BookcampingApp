# Library: a collection of shelves
class Library < ActiveRecord::Base
  has_many :shelves, order: 'updated_at DESC', dependent: :destroy
  has_many :references, dependent: :restrict
  belongs_to :user
  has_many :versions

  extend FriendlyId
  friendly_id :slug

  PUBLISHER = 'publisher'
  CAMPING = 'camping'
  GUIDES = 'guides'
  LTYPES = [CAMPING, GUIDES, PUBLISHER]

  validates_presence_of :user_id, :name, :slug, :ltype

  def shelf_items
    ShelfItem.where(shelf_id: shelves.pluck(:id)).reorder('created_at DESC')
  end

  def activity
    @activity ||= Activity.activity(self.versions, limit: 10).scoped
  end

  def ordered_shelves
    fixed_shelf_order ? shelves.reorder('created_at ASC') : shelves
  end

  def guides?
    self.ltype == 'guides'
  end
end
