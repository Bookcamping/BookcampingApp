require 'test_helper'

describe 'SubscriptionsController integration' do
  it 'can view subscription' do
    shelf = create(:shelf)
    subscription = shelf.add_subscriptor(create(:user))
    visit subscription_path(subscription)
    current_path.must_equal shelf_path(shelf, library: shelf.library)
  end

  it 'can subscribe to shelf' do
    shelf = create(:shelf)
    user = create(:user)
    login_with(user)

    visit shelf_path(shelf, library: shelf.library)
    find_action_link('subscribe').must_be :present?
    find_action_link('subscribe').click
    shelf.subscriptor?(user).must_equal true
  end

  it 'can unsubscribe to shelf' do
    shelf = create(:shelf)
    user = create(:user)
    shelf.add_subscriptor(user)
    login_with(user)

    visit shelf_path(shelf, library: shelf.library)
    find_action_link('unsubscribe').must_be :present?
    find_action_link('unsubscribe').click
    shelf.subscriptor?(user).must_equal false
  end
end
