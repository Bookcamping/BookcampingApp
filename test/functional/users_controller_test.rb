require 'test_helper'

describe 'Users controller integration' do
  it 'show user' do
    user = create(:user)
    visit user_path(user)
    must_include_resource(user, only: [:name])
  end

  it 'can create user' do
    visit new_user_path

    try_create_user
  end

  it 'can create user from login' do
    visit login_path
  end

  def try_create_user
    fill_in 'user_name', with: 'New user'
    fill_in 'user_email', with: 'name@bookcamping.cc'
    fill_in 'user_password', with: 'secret'
    fill_in 'user_password_confirmation', with: 'secret'
    click_submit
    user = User.last
    user.must_be :present?
    user.name.must_equal 'New user'
  end
end
