require 'test_helper'

describe VersionObserver do
  it 'is activity unless update' do
    reference = create(:reference)
    reference.versions.count.must_equal 1
    reference.attributes = { title: 'The new title' }
    reference.save!
    reference.versions.count.must_equal 2
    version = reference.versions.last
    version.event.must_equal 'update'
    version.activity.must_equal false
  end
end
