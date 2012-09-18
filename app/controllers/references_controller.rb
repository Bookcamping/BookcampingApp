class ReferencesController < ApplicationController
  expose(:references) { Reference.all }
  expose(:reference)
  # find_by_id porque sólo debería estar presente cuando se crea
  expose(:shelf) { Shelf.find(reference.include_in_shelf) if reference.include_in_shelf.present? }
  expose(:current_library) { shelf ? shelf.library : reference.library }

  def show
    show!(reference)
  end

  def new
    if params[:s].blank?
      redirect_to root_path, alert: 'Todas las referencias deben ir en alguna lista'
    else
      reference.include_in_shelf = params[:s]
      new!(reference)
    end
  end

  def edit
    edit!(reference)
  end

  def create
    reference.library = current_library
    reference.user = current_user
    create!(reference, :reference)
  end

  def update
    update!(reference, :reference)
  end

  def destroy
    destroy!(reference) { root_path }
  end
end
