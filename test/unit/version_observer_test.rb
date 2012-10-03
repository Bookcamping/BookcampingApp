require 'test_helper'

describe VersionObserver do
  it 'creates notifications for shelf_items' do
    shelf = create(:shelf)
    s1 = shelf.add_subscriptor(create(:user)).user
    user = create(:user)
    item = shelf.add_reference(create(:reference), user)

    s1.notifications.count.must_equal 1
    version = s1.notifications.last.version
    item.versions.must_include version
  end

end
