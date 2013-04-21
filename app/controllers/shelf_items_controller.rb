# encoding: utf-8
class ShelfItemsController < ApplicationController
  expose(:shelf) { Shelf.find params[:s] }
  expose(:search) { Search.new(params[:title]) }
  expose(:search_results) { Scope.new(search.references, order: :title) }
  expose(:reference) { Reference.find(params[:reference_id]) }
  expose(:shelf_items) { ShelfItem.scoped }
  expose(:shelf_item)
  expose(:current_library) { params[:s].present? ? shelf.library : nil }

  def index
    reference
    index!(ShelfItem)
  end

  def show
    if shelf_item.reference.present?
      redirect_to shelf_item.reference
    else
      redirect_to references_path, alert: 'Referencia no encontrada... :( ¿Quizá ha sido borrada?'
    end
  end

  def new
    new!(shelf_item)
  end

  def edit
    edit!(shelf_item)
  end

  def create
    shelf_item.shelf = shelf
    shelf_item.reference = Reference.find params[:r]
    shelf_item.user = current_user
    authorize! :create, shelf_item
    shelf_item.save
    respond_with shelf_item, location: view_shelf_path(shelf_item.shelf)
  end

  def update
    update!(shelf_item, :shelf_item) do
      UpdateShelfMetadata.perform_async(shelf_item.shelf_id)
      reference_path(shelf_item.reference)
    end
  end

  def destroy
    destroy!(shelf_item, :shelf_item) do
      #Notifier.perform_async(:shelf_item, :destroy, nil, 
      #                       shelf_name: shelf_item.shelf.name,
      #                       reference_title: shelf_item.reference.title)
      reference_path(shelf_item.reference)
    end
  end
end
