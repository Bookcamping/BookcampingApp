module LoginTestHelper
  def login_with(user)
    if user.present?
      visit enter_path(user)
    else
      visit logout_path
    end
    user
  end
end
