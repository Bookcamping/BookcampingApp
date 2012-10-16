class FollowingsController < ApplicationController
  before_filter :require_user, except: [:show, :index]
  expose(:user) { User.find params[:u] }

  def show
    redirect_to Following.find(params[:id]).user
  end

  def create
    following = current_user.follow(user)
    flash[:notice] = t('followings.created', name: user.name)
    respond_with following, location: user
  end

  def destroy
    following = current_user.followeds.find params[:id]
    user = following.user
    following.destroy
    flash[:notice] = t('followings.destroyed', name: user.name)
    respond_with following, location: user
  end
end
