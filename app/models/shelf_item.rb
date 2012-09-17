class ShelfItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :shelf
  belongs_to :reference
  belongs_to :library

  has_paper_trail meta: {
    title: Proc.new {|item| "'#{item.reference.title}' en #{item.shelf.name}" }, 
    camp_id: :camp_id
  }

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
