# LibrariesController
class LibrariesController < ApplicationController
  respond_to :html
  expose(:libraries) { Library.all }
  expose(:library)
  expose(:current_library) { library }

  def index
    index!(Library)
  end

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
