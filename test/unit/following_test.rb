require 'test_helper'

describe Following do
  it 'can follow shelf' do
    shelf = create(:shelf)
    user = create(:user)

    following = Following.create(user: user,
                                 followed: shelf)
    following.must_be :present?
    shelf.reload.followers_count.must_equal 1
  end
end
