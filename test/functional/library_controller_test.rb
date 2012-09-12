require 'test_helper'

describe 'LibrariesController integration' do
  it "show library description and shelves" do
    library = create(:library, description: 'Library desc')
    create(:shelf, library: library, name: 'Shelf 1')
    visit library_path(library)
    page.text.must_include 'Library desc'
    page.text.must_include 'Shelf 1'
  end

  it "can edit library if member" do
    library = create(:library)
    member = create(:user)
    library.add_member(member)

    login_with(nil)
    visit library_path(library)
    find_action_link('edit-library').must_equal nil

    login_with(create(:user))
    visit library_path(library)
    find_action_link('edit-library').must_equal nil

    login_with(member)
    visit library_path(library)
    find_action_link('edit-library').wont_equal nil
  end
end
