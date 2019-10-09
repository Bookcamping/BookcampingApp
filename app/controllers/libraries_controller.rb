# LibrariesController
class LibrariesController < ApplicationController
  respond_to :html
  expose(:libraries) { Library.order('created_at ASC') }
  expose(:library)
  expose(:layout_row) { params[:action] == 'index' ? nil : 'basic' }

  caches_page :index

  def dashboard
    show!(current_library)
  end

  def index
    index!(Library)
  end

  def show
    redirect_to shelves_path(library: library)
    # show!(library)
  end

  def new
    new!(library)
  end

  def edit
    edit!(library)
  end

  def create
    library.user = current_user
    create!(library, :library)
  end

  def update
    update!(library, :library)
  end

  def destroy
    destroy!(library, :library)
  end
end
