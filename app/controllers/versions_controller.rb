class VersionsController < ApplicationController
  expose(:versions) 
  expose(:version)

  def show

  end

  def destroy
    destroy!(version) { activity_path }
  end
end
