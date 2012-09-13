# encoding: utf-8
class MembershipsController < ApplicationController
  expose(:memberships) { Membership.scoped }
  expose(:membership)

  def create
    url = polymorphic_path([:edit, membership.resource])
    if membership.save 
      redirect_to url, notice: 'Madrina añadida'
    else
      redirect_to url, alert: 'Madrina no encontrada'
    end
  end

  def destroy
    destroy!(membership, :membership) do
      [:edit, membership.resource]
    end
  end
end
