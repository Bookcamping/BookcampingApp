require 'test_helper' 

describe Library do
  it "must have name" do
    library = create(:library)
    library.name.must_be :present?
  end
end
