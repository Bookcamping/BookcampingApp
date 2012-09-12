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
    shelf.members.must_include shelf.user

    member = create(:user)
    shelf.add_member(member)
    shelf.members.reload.must_include member
    shelf.memberships.count.must_equal 2
  end

  it "can be found by slug" do
    create(:shelf, name: 'My Shelf')
    Shelf.find('my-shelf').must_be :present?
  end

  it "creates memberships" do
    camp = create(:shelf)
    camp.add_member(create(:user))
    Membership.last.resource.must_equal camp
  end

end

