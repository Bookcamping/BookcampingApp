require 'test_helper'

describe 'SessionsController integration' do
  it 'perform login with email and password' do
    login_with(nil)
    user = create(:user, email: 'hola@bookcamping.cc', 
                  password: 'secret', password_confirmation: 'secret')

    visit login_path
    fill_in 'user_email', with: 'hola@bookcamping.cc'
    fill_in 'user_password', with: 'secret'
    click_submit

    page.find('.session .user').text.must_include user.name
  end

end
