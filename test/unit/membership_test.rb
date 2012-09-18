require 'test_helper'

describe Membership do
  it "have library and user" do
    library = create(:library)
    library.add_member(create(:user))
    library.memberships.first.library.must_be :present?
    library.memberships.first.user.must_be :present?
  end

  it "can't have same user for same library" do
    library = create(:library)
    member = create(:user)
    ms = Membership.new(library: library, user: member)
    ms.save.must_equal true
    ms = Membership.new(library: library, user: member)
    ms.save.must_equal false
  end
end
