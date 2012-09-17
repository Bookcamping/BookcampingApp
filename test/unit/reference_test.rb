require 'test_helper'

describe Reference do
  it "has tags" do
    reference = build(:reference)
    reference.tag_names = "Primer tag, segundo tag"
    reference.save.must_equal true
    reference.tags.count.must_equal 2
    Tag.find_tag('Primer tag').must_be :present?
    Tag.find_tag('Segundo tag').must_be :present?
  end
end
