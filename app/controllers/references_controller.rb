class ReferencesController < ApplicationController
  expose(:references) { Reference.all }
  expose(:reference)
  expose(:shelf) { Shelf.find params[:s] }

  def show
    show!(reference)
  end

  def new
    if params[:s].blank?
      redirect_to root_path, alert: 'Todas las referencias deben ir en alguna lista'
    else
      reference.include_in_shelf_id = params[:s]
      new!(reference)
    end
  end

  def edit
    edit!(reference)
  end

  def create
    create!(reference, :reference)
  end

  def update
    update!(reference, :reference)
  end
end
