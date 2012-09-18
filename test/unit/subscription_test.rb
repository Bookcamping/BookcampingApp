require 'test_helper'

describe Subscription do
  it 'has shelf_name' do
    shelf = create(:shelf)
    shelf.add_subscriptor(create(:user))
    shelf.subscriptions.last.shelf_name.must_equal shelf.name
  end
end
