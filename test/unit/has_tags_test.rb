require 'test_helper'

describe HasTags do
  it "reference has tags" do
    reference = build(:reference)
    reference.tag_names = "Primer tag, segundo tag"
    reference.save.must_equal true
    reference.tags.count.must_equal 2
    Tag.find_tag('Primer tag').must_be :present?
    Tag.find_tag('Segundo tag').must_be :present?
  end

  it 'shelves has tags' do
    shelf = create(:shelf)
    shelf.add_tag('uno')
    uno = Tag.find_tag('uno')
    uno.must_be :present?
    shelf.tags.must_include uno
  end

  it 'reference can remove tags' do
    reference = create(:reference, tag_names: 'uno, dos')
    reference.tags.count.must_equal 2
    reference.tag_names = 'uno'
    reference.save
    reference.tags.count.must_equal 1
  end
end
