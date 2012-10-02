class MembershipsController < ApplicationController
  expose(:memberships) { Membership.scoped }
  expose(:membership)

  def show
    redirect_to membership.library
  end

  def create
    url = edit_library_path(membership.library)
    if membership.save 
      redirect_to url, notice: t('memberships.created')
    else
      redirect_to url, alert: t('memberships.not_found')
    end
  end

  def destroy
    destroy!(membership, :membership) do
      edit_library_path(membership.library)
    end
  end
end
