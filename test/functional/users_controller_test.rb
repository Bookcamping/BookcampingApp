require 'test_helper'

describe 'Users controller integration' do
  it 'show user' do
    user = create(:user)
    visit user_path(user)
    must_include_resource(user, only: [:name])
  end
end
