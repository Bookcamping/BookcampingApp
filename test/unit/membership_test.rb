require 'test_helper'

describe Membership do
  it "have resource and user" do
    library = create(:library)
    library.add_member(create(:user))
    library.memberships.first.resource.must_be :present?
    library.memberships.first.user.must_be :present?
  end

  it "can't have same user for same resource" do
    library = create(:library)
    member = create(:user)
    ms = Membership.new(resource: library, user: member)
    ms.save.must_equal true
    ms = Membership.new(resource: library, user: member)
    ms.save.must_equal false
  end

  it "generates version" do
    library = create(:library)
    user = create(:user, name: 'Kamen')
    ms = Membership.create(resource: library, user: user)
    v = Version.last
    v.item_type.must_equal 'Membership'
    v.item_id.must_equal ms.id
    v.title.must_equal "Kamen a 'grupo'"
  end
end
