class ShelvesController < ApplicationController
  expose(:library) { Library.find params[:library_id] }
  expose(:shelf) { library.shelves.find params[:id] }

  def show
    show!(shelf)
  end

  def edit
    edit!(shelf)
  end

  def update
    update!(shelf, :shelf) { [library, shelf] }
  end
end
