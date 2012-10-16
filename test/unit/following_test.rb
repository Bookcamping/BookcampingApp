require 'test_helper'

describe Following do
  it "has counter caches" do
    follower = create(:user)
    followed = create(:user)
    follower.follow(followed)
    
    follower.reload
    followed.reload

    follower.follows_count.must_equal 1
    followed.follows_count.must_equal 0

    follower.followers_count.must_equal 0
    followed.followers_count.must_equal 1
  end

  it "has one version and its dependant" do
    following = create(:user).follow create(:user)
    version = following.versions.last
    following.destroy
    Version.where(item_type: 'Following').count.must_equal 0
  end
end
