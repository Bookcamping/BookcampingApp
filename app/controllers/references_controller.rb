class ReferencesController < ApplicationController
  expose(:references) { Reference.all }
  expose(:reference)

  expose(:ref_list) { Search::References.new(page: params[:p]) }
  # find_by_id porque sólo debería estar presente cuando se crea
  expose(:shelf) { Shelf.find(reference.include_in_shelf) if reference.include_in_shelf.present? }

  def index
    index!(Reference)
  end

  def show
    if params[:shelf_id].present?
      redirect_to reference
    else
      show!(reference)
    end
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
    destroy!(reference, :reference) { root_path }
  end
end
