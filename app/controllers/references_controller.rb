class ReferencesController < ApplicationController
  expose(:references) { Reference.all }
  expose(:reference)
  # find_by_id porque sólo debería estar presente cuando se crea
  expose(:shelf) { Shelf.find_by_slug(reference.include_in_shelf)  }
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
end
