require 'test_helper'

describe "References controller integration" do
  it 'lists references' do
    r1 = create(:reference)
    r2 = create(:reference)
    visit references_path
    attrs = [:title, :authors]
    must_include_resource(r1, only: attrs)
    must_include_resource(r2, only: attrs)
  end

  it 'show reference' do
    reference = create(:reference)
    visit reference_path(reference)
    must_include_resource(reference, only: [:title])
  end

  it 'creates reference' do
    create(:license)
    shelf = create(:shelf)
    user = login_with(create(:user))

    attrs = [:title, :authors, :date, :editor, :description]
    ref = build(:reference)
    visit new_reference_path(s: shelf)
    fill_in_resource(ref, only: attrs)
    click_submit
    Reference.count.must_equal 1
    must_equal_resource(Reference.last, ref, only: attrs)
    shelf.references.must_include Reference.last
  end

  it 'tag reference' do
    reference = create(:reference)
    login_with create(:user)

    visit tag_reference_path(reference)
    fill_in 'reference_tag_names', with: 'tag1, tag2'
    click_submit
    Tagging.count.must_equal 2
  end

  it 'destroys references' do
    reference = create(:reference)
    login_with(reference.user)
    visit edit_reference_path(reference)
    find_action_link('delete-reference').click
    Reference.count.must_equal 0
  end
end
