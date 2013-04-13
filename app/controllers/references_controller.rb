class ReferencesController < ApplicationController
  expose(:references) { Reference.scoped }
  expose(:reference)

  expose(:ref_list) { Scope.new(Reference.scoped, page: params[:p]) }
  expose(:shelf) { Shelf.find(params[:s]) if params[:s].present? }
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
    create!(reference, :reference) do
      if shelf
        item = shelf.add_reference(reference, current_user)
        ShelfItemNotifier.perform_async(item, action: :create)
        UpdateShelfMetadata.perform_async(shelf.id)
      end
      reference_path(reference)
    end
  end

  def update
    update!(reference, :reference) do
    end
  end

  def destroy
    destroy!(reference, :reference) { root_path }
  end
end
