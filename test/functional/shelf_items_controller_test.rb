require 'test_helper'

describe 'ShelfItems integration' do

  it 'can create shelf items if logged in' do
    user = login_with(create(:user))
    shelf = create(:shelf)

    visit new_shelf_item_path(s: shelf)

  end
end
