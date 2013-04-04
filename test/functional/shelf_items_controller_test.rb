require 'test_helper'

describe 'ShelfItems integration' do
  it 'can destroy shelf_items do' do
    user = login_with(create(:user))
    library = create(:library, user: user)
    
    shelf = create(:shelf, library: library)
    reference = create(:reference)
    item = shelf.add_reference reference

    visit reference_shelf_items_path(reference)
    page.text.must_include shelf.name
    find_action_link("destroy-shelf_item-#{item.id}").click

    reference.shelves.count.must_equal 0
  end

  it 'can create shelf items if logged in' do
    user = login_with(create(:user))
    shelf = create(:shelf)

    visit new_shelf_item_path(s: shelf)

  end
end
