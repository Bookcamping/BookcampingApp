require 'test_helper'

describe Version do
  it 'of a reference' do
    license = create(:license)
    reference = create(:reference, license: license)
    check_version(reference, library_id: reference.library_id)
  end

  it 'of a shelf' do
    shelf = create(:shelf)
    check_version(shelf, title: shelf.name, 
                  library_id: shelf.library.id,
                  shelf_id: shelf.id)
  end

  it 'of a member' do
    library = create(:library, name: 'bookcamping')
    user = create(:user, name: 'Kamen')
    membership = Membership.create(library: library, user: user)

    check_version(membership, title: "Kamen a 'bookcamping'")
  end

  it 'of a membership' do
    library = create(:library)
    user = create(:user, name: 'Kamen')
    ms = Membership.create(library: library, user: user)
    check_version(ms, title: "Kamen a '#{library.name}'")
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
