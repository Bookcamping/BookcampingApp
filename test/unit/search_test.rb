# encoding: utf-8
require 'test_helper'

describe Search do
  it 'search references' do
    i1 = create(:reference, title: 'economía')
    i2 = create(:reference, title: 'ecología')
    i3 = create(:reference, authors: 'ecoplastia')
    i4 = create(:reference, editor: 'ecolombia')
    n1 = create(:reference, description: 'economía')

    search = Search.new('eco')
    [i1, i2, i3, i4].each do |ref|
      search.references.must_include ref
    end
    [n1].each do |ref|
      search.references.wont_include ref
    end
  end

  it 'search shelves' do
    s1 = create(:shelf, name: 'ecografía')
    search = Search.new('eco')
    search.shelves.must_include s1
  end

  it 'search tags' do
    t1 = create(:tag, name: 'econometría')
    search = Search.new('eco')
    search.tags.must_include t1
  end

  it 'search is not case sensitive' do
    r = create(:reference, title: 'Ecología')
    search = Search.new('eco')
    search.references.must_include r
  end
end
