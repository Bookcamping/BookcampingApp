class ShelfReferencesController < ApplicationController
  expose(:library) { Library.find params[:library_id] }
  expose(:shelf) { library.shelves.find params[:shelf_id] }
  expose(:reference) { shelf.references.find params[:id] }

  def show

  end
end
