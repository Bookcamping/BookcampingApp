require 'test_helper'

describe 'MembershipsController integration' do
  it 'can view members' do
    library = create(:library)
    membership = library.add_member(create(:user))

    visit membership_path(membership)
    current_path.must_equal shelves_path(library: library)
  end

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

  it 'can remove members' do
    library = create(:library)
    user = create(:user)
    library.add_member(user)
    member = create(:user)
    ms = library.add_member(member)
    login_with(user)

    visit edit_library_path(library)
    find_action_link("delete-membership-#{ms.id}").click
    library.member?(member).must_equal false
  end
end
