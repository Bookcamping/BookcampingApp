require 'test_helper'

describe VersionObserver do
  it 'is activity unless update' do
    reference = create(:reference)
    reference.versions.count.must_equal 1
    reference.attributes = { title: 'The new title' }
    reference.save!
    reference.versions.count.must_equal 2
    version = reference.versions.last
    version.event.must_equal 'update'
    version.activity.must_equal false
  end

  it 'creates notifications for shelf_items' do
    shelf = create(:shelf)
    s1 = shelf.add_subscriptor(create(:user)).user
    user = create(:user)
    item = shelf.add_reference(create(:reference), user)

    s1.notifications.count.must_equal 1
    version = s1.notifications.last.version
    item.versions.must_include version
    s1.reload
    s1.email_pending?.must_equal true
  end

end
