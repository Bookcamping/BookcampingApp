# LibrariesController
class LibrariesController < ApplicationController
  respond_to :html
  expose(:library) { Library.find(params[:id]) }

  def edit
    authorize! :update, library
    respond_with library
  end

  def update
    authorize! :update, library
    library.update_attributes(permitted_params.library)
    flash[:notice] = t('updated') if library.save
    respond_with library
  end
end
