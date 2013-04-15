require 'test_helper'

describe UpdateShelfMetadata do

  it 'add editors' do
    shelf = create(:shelf)
    reference = create(:reference)
    shelf.add_reference(reference)

    UpdateShelfMetadata.new.perform(shelf.id)

    shelf.editors.count.must_equal 1
    shelf.users.must_include reference.user
  end

  it 'add tags' do
    shelf = create(:shelf)
    shelf.add_reference(create(:reference, tag_names: 'uno, dos'))
    shelf.add_reference(create(:reference, tag_names: 'dos, tres'))

    UpdateShelfMetadata.new.perform(shelf.id)

    shelf.tags.count.must_equal 3
  end

end
