require 'test_helper' 

describe User do
  it 'can be asked to send email' do
    user = create(:user, email: 'email@domain.com')
    user.send_email?.must_equal true
    updated_at = user.updated_at.to_i
    user.reload
    user.email_pending?.must_equal true
    user.updated_at.to_i.must_equal updated_at
  end
end
