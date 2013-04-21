require 'test_helper'

describe HasFollowers do
  it 'have followings'  do
    shelf = create(:shelf)
    following = Following.create(user: create(:user),
                     followed: shelf)

    shelf.reload
    shelf.followings.must_include following
  end

  it 'have followers' do
    shelf = create(:shelf)
    user = create(:user)
    Following.create(user: user,
                     followed: shelf)
    shelf.reload
    shelf.followers.must_include user
  end

  it 'adds owner as follower' do
    shelf = create(:shelf)
    shelf.followings.count.must_equal 1
    shelf.followers.must_include shelf.user
  end

  it 'can add follower' do
    shelf = create(:shelf)
    user = create(:user)
    shelf.add_follower(user)
    shelf.followers.must_include user
  end

  it 'can find following for user' do
    shelf = create(:shelf)
    follower = create(:user)

    following = shelf.add_follower(follower)
    shelf.following_for(follower).must_equal following
  end

  it "can't add same follower twice" do
    shelf = create(:shelf)
    follower = create(:user)

    shelf.add_follower(follower)
    shelf.add_follower(follower)
    shelf.followers.count.must_equal 2 # owner and follower
  end
end
