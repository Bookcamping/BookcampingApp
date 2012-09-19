# encoding: utf-8
class MembershipsController < ApplicationController
  expose(:memberships) { Membership.scoped }
  expose(:membership)

  def show
    redirect_to membership.library
  end

  def create
    url = edit_library_path(membership.library)
    if membership.save 
      redirect_to url, notice: 'Madrina añadida'
    else
      redirect_to url, alert: 'Madrina no encontrada'
    end
  end

  def destroy
    destroy!(membership, notice: 'Adios, madrina...') do
      edit_library_path(membership.library)
    end
  end
end
