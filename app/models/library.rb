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
  SHELVES_ORDER = [:last_created_first, :last_created_last, :last_modified_first, :alphabetically]

  validates_presence_of :user_id, :name, :slug, :ltype

  def shelf_items
    ShelfItem.where(shelf_id: shelves.pluck(:id)).reorder('created_at DESC')
  end

  def activity
    @activity ||= Activity.activity(self.versions, limit: 10).scoped
  end

  def ordered_shelves
    case shelves_order
    when 'last_created_first'
      shelves.reorder('created_at ASC')
    when 'last_created_first'
      shelves.reorder('created_at DESC')
    when 'last_modified_first'
      shelves.reorder('updated_at DESC')
    else
      shelves.reorder('title ASC')
    end
  end

  def guides?
    self.ltype == 'guides'
  end
end
