require 'test_helper'

describe Reference do
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

  it 'add link when url' do
    reference = create(:reference, url: 'http://bookcamping.cc')
    reference.url.must_equal 'http://bookcamping.cc'
    reference.links.count.must_equal 1

    ref = Reference.find reference.id
    ref.url.must_equal 'http://bookcamping.cc/'
    ref.url = 'http://videocamping.cc'
    ref.save
    ref.links.count.must_equal 1
    ref.links.first.url.must_equal 'http://videocamping.cc/'
  end
end
