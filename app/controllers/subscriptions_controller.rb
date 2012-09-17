class SubscriptionsController < ApplicationController
  before_filter :require_user
  expose(:subscriptions)
  expose(:subscription)

  def show
    redirect_to [subscription.resource.library, subscription.resource]
  end

  def create
    shelf = Shelf.find_by_slug!(params[:s])
    shelf.add_subscriber(current_user)
    redirect_to [shelf.library, shelf], 
      notice: t('subscriptions.created', name: shelf.name)
  end

  def destroy
    destroy!(subscription, notice: t('subscriptions.destroyed', name: subscription.resource.name)) do
      [subscription.resource.library, subscription.resource]
    end
  end
end
