require 'test_helper'

describe Shelf do
  it "requires name and user" do
    shelf = create(:shelf)
    shelf.name.must_be :present?
    shelf.user.must_be :present?
  end

  it "create versions" do
    shelf = create(:shelf)
    v = Version.last
    v.item_type.must_equal 'Shelf'
    v.item_id.must_equal shelf.id
  end

  it "have members" do
    shelf = create(:shelf)
    shelf.add_member(create(:user))
    shelf.memberships.count.must_equal 1
  end

  it "can be found by slug" do
    create(:user_shelf, name: 'My Shelf')
    UserShelf.find('my-shelf').must_be :present?
  end

  it "creates memberships" do
    camp = create(:camp_shelf)
    camp.add_member(create(:user))
    Membership.last.resource.must_equal camp
  end

end

