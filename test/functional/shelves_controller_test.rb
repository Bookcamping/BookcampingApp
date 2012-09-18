require 'test_helper' 

describe "ShelvesController integration" do
  it 'show shelves of a library' do
    library = create(:library)
    shelf1 = create(:shelf, library: library)
    shelf2 = create(:shelf, library: library)
    shelf3 = create(:shelf)

    visit shelves_path(library: library)
    page.text.must_include shelf1.name
    page.text.must_include shelf2.name
    page.text.wont_include shelf3.name
  end

  it 'show shelf' do
    shelf = create(:shelf)
    visit shelf_path(shelf, library: shelf.library)
    must_include_resource(shelf, only: [:name, :description])
  end

  it 'can create shelf if user logged in' do
    library = create(:library)
    visit shelves_path(library: library)
    find_action_link('new-shelf').must_be :blank?
    login_with(create(:user))
    visit shelves_path(library: library)
    find_action_link('new-shelf').must_be :present?
  end

  it 'creates new shelf' do
    library = create(:library)
    user = login_with(create(:user))

    visit new_shelf_path(library: library)
    fill_in_resource(build(:shelf), only: [:name, :description])
  end

end
