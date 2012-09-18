class ShelvesController < ApplicationController
  expose(:library) { Library.find params[:library] }
  expose(:shelves) { library.shelves }
  expose(:shelf)
  expose(:activity) { Activity.new(shelf) }
  expose(:current_library) { library }

  def index
  end

  def show
    if params[:library].blank?
      rshelf = Shelf.find params[:id]
      redirect_to shelf_path(rshelf, library: shelf.library)
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

  def create
    shelf.library = library
    shelf.user = current_user
    create!(shelf, :shelf) { shelf_path(shelf, library: library) }
  end

  def update
    update!(shelf, :shelf) { shelf_path(shelf, library: library) }
  end

  def destroy
    destroy!(shelf) { library }
  end
end
