require 'texticle/searchable'

class Shelf < ActiveRecord::Base
  include ActiveModel::Dirty
  #define_attribute_methods :library_id

  belongs_to :library, touch: true
  belongs_to :user
  has_many :shelf_items, order: 'created_at ASC', dependent: :delete_all
  has_many :references, through: :shelf_items
  has_many :editors, as: :editable
  has_many :users, through: :editors

  include HasTags
  include HasFollowers

  validates_presence_of :user_id, :library_id, :name
  validates_uniqueness_of :name
  before_save :touch_prev_library_if_changed

  extend FriendlyId
  friendly_id :name, use: :slugged
  has_paper_trail meta: {
    title: :name,
    library_id: :library_id,
    shelf_id: :id
  }
  extend Searchable(:name)

  VISUALIZATIONS = ['icons', 'list', 'publisher', 'visit']

  def guide?
    library.guides?
  end

  def add_reference(reference, user = nil)
    user ||= reference.user

    item = ShelfItem.where(shelf_id: self.id, reference_id: reference.id).first
    item ||= ShelfItem.create!(shelf_id: self.id, reference_id: reference.id,
                                user_id: user.id)
  end

  def normalize_friendly_id(string)
    super[0..49]
  end

  private
  def touch_prev_library_if_changed
    if self.library_id_changed? && self.library_id_was
      Library.find(self.library_id_was).touch
    end
  end

end
