require 'test_helper'

describe Tag do
  it 'converts name to downcase' do
    tag = Tag.create(name: 'First')
    tag.reload
    tag.name.must_equal 'first'
  end

  it 'strip name' do
    tag = Tag.create(name: '   Tag    ')
    tag.reload
    tag.name.must_equal 'tag'
  end

  it 'find by tag name' do
    tag = Tag.create(name: ' This is a tag')
    Tag.find_tag('this is a tag   ').must_equal tag
  end

  it 'is unique per name' do
    tag = Tag.create(name: 'Tag')
    tag2 = Tag.new(name: 'Tag')
    tag2.save.must_equal false
  end
end
