require 'test_helper'

describe "FollowingsController integration" do
  it 'user can follow other' do
    user = create(:user)
    followed = create(:user)

    login_with user
    visit user_path(followed)
    find_action_link!('follow').click
    user.follows.must_include followed
  end

  it 'user can unfollow' do
    user = create(:user)
    followed = create(:user)
    user.follow(followed)

    login_with user
    visit user_path(followed)
    find_action_link!('unfollow').click
    user.follows.wont_include followed
  end

end
