class ShelvesController < ApplicationController
  expose(:library) { Library.find params[:library_id] }
  expose(:shelf) { library.shelves.find params[:id] }
  def show

  end
end
