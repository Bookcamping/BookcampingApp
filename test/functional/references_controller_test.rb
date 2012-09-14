require 'test_helper'

describe "References controller integration" do
  it 'show reference' do
    reference = create(:reference)
    visit reference_path(reference)
    must_include(reference, [:title])
  end
end
