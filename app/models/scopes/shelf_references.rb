class Scopes::ShelfReferences
  attr_reader :references

  def initialize(shelf, type, order)
    @references = fetch(shelf, type, order)
  end

  protected
  def fetch(shelf, type, order)
    refs = Reference.joins(:shelf_items).
      where(shelf_items: {shelf_id: shelf.id})

    if type == 'l'
      refs = refs.where(libre: true)
    end

    if order == 'ir'
      refs = refs.order('shelf_items.created_at ASC')
    elsif order == 'd'
      refs = refs.order('date')
    else
      refs = refs.order('shelf_items.created_at DESC')
    end
    refs.includes(:license)
  end
end
