require 'test_helper'

describe 'LinksController integration' do
  it 'has links' do
    link = create(:link)

    visit reference_path(link.reference)
    page.text.must_include link.description
  end
end
