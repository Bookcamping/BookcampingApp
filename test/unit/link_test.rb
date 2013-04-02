require 'test_helper'

describe Link do
  it 'has position' do
    ref = create(:reference)
    d1 = create(:link, reference: ref)
    d1.position.must_equal 1
    d2 = create(:link, reference: ref)
    d2.position.must_equal 2
    d3 = create(:link)
    d3.position.must_equal 1
  end

  it 'has mime_type' do
    d = create(:link, url: 'http://ab.com/file.pdf')
    d.mime_type.must_equal '.pdf'
    d = create(:link, url: 'http://ab.com/file.epub')
    d.mime_type.must_equal '.epub'
  end

  it 'has host' do
    d = create(:link, url: 'http://archive.org/stream/educacionExpandidaLibro/educacion_expandida-ZEMOS98')
    d.host.must_equal 'archive.org'
  end

  it 'builds a link' do
    l = create(:link, url: 'http://aa.org', description: 'go')
    l.link.must_equal 'go: http://aa.org/'
  end

  it 'builds from link' do
    l = Link.create(link: 'go: bookcamping.cc')
    l.url.must_equal 'http://bookcamping.cc/'
    l.description.must_equal 'go'
  end
end
