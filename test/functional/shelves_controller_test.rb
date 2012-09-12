require 'test_helper' 

describe "ShelvesController integration" do
  it 'can create shelf if library open' do

  end

  it 'creates new shelf' do
    library = create(:library)
    login_with(create(:user))

    visit new_library_shelf_path(library)
    fill_in 'shelf_name', with: 'Name'
    fill_in 'shelf_description', with: 'Desc'
    shelf = Shelf.last
    shelf.must_be :present?
    shelf.library.must_equal library
    shelf.user.must_equal user
    shelf.name.must_equal 'Name'
    shelf.description.must_equal 'Description'
  end

end
