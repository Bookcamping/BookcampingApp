class Shelf < ActiveRecord::Base
  belongs_to :library
  belongs_to :user
  has_many :shelf_items, order: 'created_at ASC', dependent: :delete_all
  has_many :references, through: :shelf_items
  include HasSubscriptions

  validates_presence_of :user_id, :library_id, :name

  extend FriendlyId
  friendly_id :name, use: :slugged
  has_paper_trail meta: {
    title: :name, 
    library_id: :library_id,
    shelf_id: :id 
  }

  def add_reference(reference, user = nil)
    user ||= reference.user
    unless ShelfItem.where(shelf_id: self.id).where(reference_id: reference.id).first
      ShelfItem.create!(shelf: self, reference_id: reference.id, user_id: user.id)
    end
  end

  def normalize_friendly_id(string)
    super[0..49]
  end

end
