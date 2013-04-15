require 'test_helper'

describe Notifier do
  it 'notify shelf creation' do
    shelf = create(:shelf)
    Notifier.new.perform(:shelf, :create, shelf.id)
  end

  it 'notify shelf_item creation' do
    shelf = create(:shelf)
    item = shelf.add_reference(create(:reference))

    Notifier.new.perform(:shelf_item, :create, item.id)
  end

  it 'notify email_test creation' do
    Notifier.new.perform(:test_email, :create, nil)
  end
end
