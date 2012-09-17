require 'test_helper'

describe Subscription do
  it 'has resource_name' do
    shelf = create(:shelf)
    shelf.add_member(create(:user))
    shelf.subscriptions.last.shelf_name.must_equal shelf.name
  end
end
