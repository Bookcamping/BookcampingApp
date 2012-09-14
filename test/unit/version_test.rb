require 'test_helper'

describe Version do
  it 'of a reference' do
    license = create(:license)
    reference = create(:reference, license: license)
    check_version(reference, library_id: reference.library_id)
  end

  it 'of a member' do
    library = create(:library, name: 'bookcamping')
    user = create(:user, name: 'Kamen')
    membership = Membership.create(resource: library, user: user)

    check_version(membership, title: "Kamen a 'bookcamping'")
  end

  def check_version(resource, values = {})
    v = resource.versions.last
    v.must_be :present?
    v.item.must_equal resource
    values.each do |key, value|
      v.send(key).must_equal value
    end
  end
end
