class FollowingsController < ApplicationController
  before_filter :require_user, except: :show
  expose(:followings)
  expose(:following)

  def show
    redirect_to followed_path(following)
  end

  def create
    parent = Shelf.find_by_slug!(params[:s]) if params[:s].present?
    f = parent.add_follower(current_user)
    redirect_to followed_path(f),
      notice: t('followings.created', name: parent.name)
  end

  def destroy
    authorize! :delete, following
    flash[:notice] = t('followings.destroyed', name:
                       following.followed.name) if following.destroy
    redirect_to followed_path(following)
  end

  private
  def followed_path(following)
    if following.followed_type == 'Shelf'
      view_shelf_path(following.followed)
    end
  end
end
