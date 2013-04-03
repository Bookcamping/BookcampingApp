require 'test_helper'

describe 'LibrariesController integration' do
  visible_attributes = [:name, :description]
  it "show library description and shelves" do
    library = create(:library)
    visit library_path(library)
    must_include_resource(library, only: visible_attributes)
  end

  it 'creates library' do
    user = create(:user, site_member: true)
    login_with user

    visit new_library_path
    lib = build(:library)
    fill_in_resource lib, only: visible_attributes
    fill_in 'library_slug', with: lib.slug
    click_submit
    must_equal_resource(Library.last, lib, only: visible_attributes)
  end

  it "update library" do
    user = create(:user)
    library = create(:library, user: user)

    login_with(user)
    visit edit_library_path(library)
    lib2 = create(:library)
    fill_in_resource(lib2, only: visible_attributes)
    click_submit
    must_include_resource(lib2, only: visible_attributes)
  end

  it "can edit library if owner" do
    member = create(:user)
    library = create(:library, user: user)

    login_with(nil)
    visit library_path(library)
    find_action_link('edit-library').must_be :blank?

    login_with(create(:user))
    visit library_path(library)
    find_action_link('edit-library').must_be :blank?

    login_with(member)
    visit library_path(library)
    find_action_link('edit-library').must_be :present?
  end
end
