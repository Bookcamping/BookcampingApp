module HasSubscriptions
  extend ActiveSupport::Concern

  included do
    has_many :subscriptions, dependent: :delete_all, order: 'created_at DESC'
    has_many :subscriptors, through: :subscriptions, source: :user

    after_create do
      add_subscriptor(self.user)
    end
  end

  def add_subscriptor(user)
    Subscription.create(shelf: self, user: user)
  end

  def subscription_for(user)
    Subscription.where(shelf_id: self.id, user_id: user.id).first
  end

  def subscriptor?(user)
    subscription_for(user).present?
  end
end
