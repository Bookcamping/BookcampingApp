require 'test_helper'

describe 'VersionsController integration' do
  it 'has site versions' do
    visit versions_path
  end

  it 'shelves have versions' do
    shelf = create(:shelf)
    visit shelf_versions_path(shelf, library: shelf.library)
  end
end
