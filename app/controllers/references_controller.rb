class ReferencesController < ApplicationController
  expose(:references) { Reference.scoped }
  expose(:reference)

  expose(:ref_list) { Scope.new(Reference.scoped, page: params[:p]) }
  expose(:shelf) { Shelf.find(reference.include_in_shelf) if reference.include_in_shelf.present? }
  expose(:current_library) { reference.library }
  expose(:layout_row) { nil }

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

  [:tag, :publish, :coverize].each do |action|
    define_method action do
      edit!(reference)
    end
  end

  def create
    reference.library = shelf.library
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
