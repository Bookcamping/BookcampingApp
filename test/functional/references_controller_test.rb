require 'test_helper'

describe "References controller integration" do
  it 'show reference' do
    reference = create(:reference)
    visit reference_path(reference)
    must_include_resource(reference, only: [:title])
  end

  it 'creates reference' do
    create(:license)
    shelf = create(:shelf)
    user = login_with(create(:user))

    visit new_reference_path(s: shelf)
    fill_in_resource(build(:reference), only: [:title, :authors, :date, :editor, :description])
    click_submit
  end
end
