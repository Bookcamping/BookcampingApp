class ShelfItemsController < ApplicationController
  expose(:shelf) { Shelf.find params[:s] }
  expose(:search) { Search.new(:references, Reference.order('title ASC'), params[:title]) }
  expose(:shelf_items)
  expose(:shelf_item)

  def show
    redirect_to [shelf_item.shelf.library, shelf_item.shelf]
  end

  def new
    new!(shelf_item)
  end

  def create
    shelf_item.shelf = shelf
    shelf_item.reference = Reference.find params[:r]
    shelf_item.user = current_user
    shelf_item.library = current_library
    authorize! :create, shelf_item
    shelf_item.save
    respond_with shelf_item, location: [shelf_item.shelf.library, shelf_item.shelf]
  end
end
