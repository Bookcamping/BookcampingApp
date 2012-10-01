class ShelfItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :shelf, touch: true
  belongs_to :reference, counter_cache: true
  belongs_to :library

  delegate :name, to: :shelf, prefix: true

  has_paper_trail meta: {
    title: :shelf_name,
    library_id: :library_id,
    shelf_id: :shelf_id
  }

  validates_presence_of :user_id, :shelf_id, :reference_id, :library_id

  after_create :add_reference_to_shelf
  after_destroy :remove_reference_from_shelf


  protected
  def add_reference_to_shelf
    PaperTrail.without_versioning do
      current = shelf.references_count
      shelf.update_attribute(:references_count, current + 1)
    end
  end

  def remove_reference_from_shelf
    PaperTrail.without_versioning do
      shelf.update_attribute(:references_count, (shelf.references_count - 1))
    end
  end
end
