class SubscriptionsController < ApplicationController
  before_filter :require_user
  expose(:subscriptions)
  expose(:subscription)

  def show
    redirect_to view_shelf_path(subscription.shelf)
  end

  def create
    shelf = Shelf.find_by_slug!(params[:s])
    shelf.add_subscriptor(current_user)
    redirect_to view_shelf_path(shelf),
      notice: t('subscriptions.created', name: shelf.name)
  end

  def destroy
    destroy!(subscription, notice: t('subscriptions.destroyed', name: subscription.shelf.name)) do
      view_shelf_path(subscription.shelf)
    end
  end
end
