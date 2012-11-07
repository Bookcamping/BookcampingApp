# LibrariesController
class LibrariesController < ApplicationController
  respond_to :html
  expose(:libraries) { Library.all }
  expose(:library)

  def dashboard
    show!(current_library)
  end

  def index
    index!(Library)
  end

  def show
    show!(library)
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
end
