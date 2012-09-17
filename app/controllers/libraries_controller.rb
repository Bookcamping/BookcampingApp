# LibrariesController
class LibrariesController < ApplicationController
  respond_to :html
  expose(:library) { Library.find(params[:id]) }
  expose(:current_library) { library }

  def show
    show!(library)
  end

  def edit
    edit!(library)
  end

  def update
    update!(library, :library)
  end
end
