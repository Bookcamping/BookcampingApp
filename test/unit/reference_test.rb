require 'test_helper'

describe Reference do

  it "added to shelf automagically" do
    shelf = create(:shelf)
    reference = build(:reference)
    reference.include_in_shelf = shelf.id
    reference.save.must_equal true
    shelf.references.must_include reference
  end

  it "is libre by its license" do
    license = create(:license, libre: true)
    reference = create(:reference, license: license)
    reference.libre?.must_equal true
  end

  it 'is libre when updated to a new license' do
    reference = create(:reference)
    reference.libre?.must_equal false
    license = create(:license, libre: true)
    reference.license_id = license.id
    reference.save
    reference.libre?.must_equal true
  end

end
