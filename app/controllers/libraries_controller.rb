# LibrariesController
class LibrariesController < ApplicationController
  respond_to :html
  expose(:library) { Library.find(params[:id]) }

  def edit
    edit!(library)
  end

  def update
    update!(library, :library)
  end
end
