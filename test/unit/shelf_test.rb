require 'test_helper'

describe Shelf do
  it "requires name and user" do
    shelf = create(:shelf)
    shelf.name.must_be :present?
    shelf.user.must_be :present?
  end

  it "can be found by slug" do
    create(:shelf, name: 'My Shelf')
    Shelf.find('my-shelf').must_be :present?
  end

  it 'can add reference' do
    shelf = create(:shelf)
    reference = create(:reference)
    item = shelf.add_reference(reference)
    item.must_be :present?
    shelf.references.must_include reference
    item2 = shelf.add_reference(reference)
    item2.must_be :present?
    item2.must_equal item
  end
end

