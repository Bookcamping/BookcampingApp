class VersionsController < ApplicationController
  expose(:versions) 
  expose(:version)

  def show
  end

  def edit
    edit!(version)
  end

  def update
    update!(version, :version)
  end

  def destroy
    destroy!(version) { activity_path }
  end
end
