require 'test_helper'

describe 'SubscriptionsController integration' do
  it 'can subscribe to shelf' do
    shelf = create(:shelf)
    user = create(:user)
    login_with(user)

    visit shelf_path(shelf, library: shelf.library)
    find_action_link('subscribe').must_be :present?
    find_action_link('subscribe').click
    page.find(".subscriptors").text.must_include user.name
  end

  it 'can unsubscribe to shelf' do
    shelf = create(:shelf)
    user = create(:user)
    shelf.add_subscriptor(user)
    login_with(user)

    visit shelf_path(shelf, library: shelf.library)
    page.find(".subscriptors").text.must_include user.name
    find_action_link('unsubscribe').must_be :present?
    find_action_link('unsubscribe').click
    page.find(".subscriptors").text.wont_include user.name
  end
end
