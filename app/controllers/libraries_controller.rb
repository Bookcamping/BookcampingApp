# LibrariesController
class LibrariesController < ApplicationController
  respond_to :html
  expose(:library) { Library.find(params[:id]) }
  expose(:current_library) { library }

  def show
    redirect_to shelves_path(library: library)
  end

  def edit
    edit!(library)
  end

  def update
    update!(library, :library)
  end
end
