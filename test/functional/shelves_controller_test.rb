require 'test_helper' 

describe "ShelvesController integration" do
  attributes = [:name, :description]

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

  it 'updates library_id in shelf' do
    user = login_with(create(:user), admin: true)
    shelf = create(:shelf)
    library = create(:library)

    visit edit_shelf_path(shelf, library: shelf.library)
    select library.name, from: 'shelf_library_id'
    click_submit
    shelf.reload
    shelf.library.must_equal library
  end

  it 'updates shelf' do
    shelf = create(:shelf)
    login_with(create(:user))

    visit edit_shelf_path(shelf, library: shelf.library)
    s2 = build(:shelf)
    fill_in_resource(s2, only: attributes)
    click_submit
    shelf.reload
    must_equal_resource(shelf, s2, only: attributes)
  end

  it 'show shelf' do
    shelf = create(:shelf)
    visit shelf_path(shelf, library: shelf.library)
    must_include_resource(shelf, only: attributes)
  end

  it 'creates new shelf' do
    library = create(:library)
    user = login_with(create(:user))

    visit new_shelf_path(library: library)
    shelf = build(:shelf)
    fill_in_resource(shelf, only: attributes)
    click_submit
    must_equal_resource(Shelf.last, shelf, only: attributes)
    must_include_resource(shelf, only: attributes)
  end

end
