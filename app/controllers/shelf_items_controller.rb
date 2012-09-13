class ShelfItemsController < ApplicationController
  def show
    item = ShelfItem.find params[:id]
    redirect_to [item.shelf.library, item.shelf]
  end
end
