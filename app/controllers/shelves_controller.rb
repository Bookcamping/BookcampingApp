class ShelvesController < ApplicationController
  expose(:library) { Library.find params[:library_id] }
  expose(:shelves) { library.shelves }
  expose(:shelf)
  expose(:current_library) { library }

  def show
    if params[:library_id].blank?
      rshelf = Shelf.find params[:id]
      redirect_to [rshelf.library, rshelf]
    else
      show!(shelf)
    end
  end

  def new
    new!(shelf)
  end

  def edit
    edit!(shelf)
  end

  def update
    update!(shelf, :shelf) { [library, shelf] }
  end

  def create
    create!(shelf, :shelf) { [library, shelf] }
  end
end
