require 'test_helper'

describe 'MembershipsController integration' do

  it 'can add members' do
    library = create(:library)
    user = create(:user)
    library.add_member(user)
    login_with(user)

    guest = create(:user)
    visit edit_library_path(library)
    fill_in 'membership_user_name', with: guest.name
    click_submit 'membership_commit'
    library.member?(guest).must_equal true
    find('.memberships').text.must_include guest.name
  end
end
