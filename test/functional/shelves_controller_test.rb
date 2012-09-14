require 'test_helper' 

describe "ShelvesController integration" do
  it 'show shelf' do
    shelf = create(:shelf)
    visit library_shelf_path(shelf.library, shelf)
    must_include_resource(shelf, only: [:name, :description])
  end

  it 'can create shelf if library open' do
  end

  it 'creates new shelf' do
    library = create(:library)
    user = login_with(create(:user))

    visit new_library_shelf_path(library)
    fill_in_resource(build(:shelf), only: [:name, :description])
  end

end
