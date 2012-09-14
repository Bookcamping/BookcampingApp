require 'test_helper'

describe 'Users controller integration' do
  it 'show user' do
    user = create(:user)
    visit user_path(user)
    must_include(user, [:name])
  end
end
