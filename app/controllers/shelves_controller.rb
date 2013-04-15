class ShelvesController < ApplicationController
  expose(:library) { Library.find params[:library] }
  expose(:shelves) { library.shelves }
  expose(:shelf)
  expose(:shelf_references) do
    Scopes::ShelfReferences.new(shelf, params[:t], params[:o]).references
  end
  expose(:current_library) { library }
  expose(:layout_row) { ['index'].include?(action_name) ? nil : 'basic' }

  def index
    respond_with library
  end

  def show
    rshelf = Shelf.find params[:id]
    if params[:library].blank? || rshelf.library_id != library.id
      redirect_to shelf_path(rshelf, library: rshelf.library)
    else
      show!(shelf)
    end
  end

  def new
    new!(shelf)
  end

  def edit
    edit!(shelf)
  end

  def create
    shelf.library = library
    shelf.user = current_user
    create!(shelf, :shelf) do
      Notifier.perform_async(:shelf, :create, shelf.id)
      shelf_path(shelf, library: library)
    end
  end

  def update
    update!(shelf, :shelf) do
      UpdateShelfMetadata.perform_async(shelf.id)
      view_shelf_path(shelf) 
    end
  end

  def destroy
    destroy!(shelf, :shelf) { library }
  end
end
