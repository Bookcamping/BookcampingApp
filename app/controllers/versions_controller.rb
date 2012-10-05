class VersionsController < ApplicationController
  respond_to :html, :js

  expose(:versions) 
  expose(:version)

  expose_parent [:shelf, :reference], default: Site
  expose(:activity) { Scope.new(parent.versions.where(activity: true), page: params[:p]) }

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
