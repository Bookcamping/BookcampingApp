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

  it 'of a shelf_item' do
    shelf = create(:shelf)
    item = shelf.add_reference(create(:reference))
    check_version(item, event: 'create', shelf_id: shelf.id)
    item.destroy
    check_version(item, event: 'destroy', shelf_id: shelf.id)
  end

  def check_version(resource, values = {})
    v = resource.versions.last
    v.must_be :present?
    v.item.must_equal resource if v.event != 'destroy'
    values.each do |key, value|
      v.send(key).must_equal value
    end
  end
end
