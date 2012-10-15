require 'test_helper' 

describe HasFollowings do
  it 'can follow' do
    user = create(:user)
    followed = create(:user)
    user.follow(followed)
    user.follows.must_include followed
    followed.followers.must_include user
  end
end
