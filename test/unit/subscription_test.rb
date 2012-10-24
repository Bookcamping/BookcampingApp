require 'test_helper'

describe Subscription do
  it 'has shelf_name' do
    shelf = create(:shelf)
    shelf.add_subscriptor(create(:user))
    shelf.subscriptions.last.shelf_name.must_equal shelf.name
  end

  it 'has one version an its dependent' do
    subscription = create(:shelf).add_subscriptor(create(:user))
    subscription.versions.count.must_equal 1
    subscription.destroy
    Version.where(item_type: 'Subscription',
                  item_id: subscription.id).count.must_equal 0
  end
end
