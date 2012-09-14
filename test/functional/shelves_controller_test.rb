require 'test_helper' 

describe "ShelvesController integration" do
  it 'show shelf' do
    shelf = create(:shelf)
    visit library_shelf_path(shelf.library, shelf)
    page.must_include shelf.title
  end

  it 'can create shelf if library open' do
  end

  it 'creates new shelf' do
    library = create(:library)
    user = login_with(create(:user))

    visit new_library_shelf_path(library)
    fill_in 'shelf_name', with: 'Name'
    fill_in 'shelf_description', with: 'Desc'
    click_submit

    shelf = Shelf.last
    shelf.must_be :present?
    shelf.library.must_equal library
    shelf.user.must_equal user
    shelf.name.must_equal 'Name'
    shelf.description.must_equal 'Desc'
  end

end
