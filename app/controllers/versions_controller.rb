class VersionsController < ApplicationController
  respond_to :html, :js

  expose(:versions) 
  expose(:version)

  expose_parent [:shelf, :reference], default: Site
  expose(:activity) { Search::Versions.new(parent, page: params[:p], per_page: 30) }

  def index
  end

  def show
  end

  def edit
    edit!(version)
  end

  def update
    update!(version, :version)
  end

  def destroy
    destroy!(version, :version) { versions_path }
  end
end
