require 'test_helper'

describe 'FollowingController integration' do
  it 'can view follower' do
    shelf = create(:shelf)
    following = shelf.add_follower(create(:user))

    visit following_path(following)
    current_path.must_equal shelf_path(shelf, library: shelf.library)
  end

  it 'can follow a shelf' do
    shelf = create(:shelf)
    user = create(:user)
    login_with(user)

    visit shelf_path(shelf, library: shelf.library)
    find_action_link('follow').must_be :present?
    find_action_link('follow').click
    shelf.followers.must_include user
  end

  it 'can unfollow shelf' do
    shelf = create(:shelf)
    user = create(:user)
    shelf.add_follower(user)
    login_with(user)

    visit shelf_path(shelf, library: shelf.library)
    find_action_link('unfollow').must_be :present?
    find_action_link('unfollow').click
    shelf.followers.wont_include user
  end
end
