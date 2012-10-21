require 'test_helper'

describe 'LinksController integration' do
  it 'has links' do
    link = create(:link)

    visit reference_path(link.reference)
    page.text.must_include link.description
  end

  it 'can update links' do
    link = create(:link)
    login_with create(:user)

    visit edit_reference_link_path(link.reference, link)
    fill_in 'link_description', with: 'Article source'
    click_submit
    page.text.must_include 'Article source'
  end

  it 'can delete links' do
    reference = create(:reference)
    link = create(:link, reference: reference)
    login_with create(:user)

    visit reference_links_path(reference)
    find_action_link("delete-link-#{link.id}").click
    reference.links.count.must_equal 0
  end
end
