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
    shelf.add_reference(reference)
    shelf.references.must_include reference
  end
end

