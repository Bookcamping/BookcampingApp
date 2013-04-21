# encoding: utf-8
module Site
  class Tab < Struct.new(:label, :path)
  end

  def featured_libraries
    Library.where(featured: true).order('created_at ASC')
  end

  def featured_shelves
    Shelf.where(featured: true).order('RANDOM()')
  end

  def featured_published_reference
    # http://stackoverflow.com/questions/15184551/how-to-fetch-a-random-record-in-rails
    Reference.where(featured: true).order('RANDOM()').first
  end

  def host
    Rails.env.production? ? 'bookcamping.cc' : 'localhost:3000'
  end

  def visible_libraries
    @visible_libraries ||= Library.where(visible_on_header: true)
  end

  def footer_links
    {
      'Agradecimientos enormes' => '/agradecimientos',
      'Contactar' => '/contactar',
      'Sobre nosotras' => '/nosotras'
    }
  end

  def tabs
    @tabs ||= [
      Tab.new('Inicio', '/portada'),
      Tab.new('Blog', 'http://blog.bookcamping.cc'),
      Tab.new('Mapa', '/mapa'),
      Tab.new('¿Cómo?', '/como')
    ]
    @tabs
  end

  def name
    'Bookcamping'
  end

  def versions
    Version.scoped
  end

  extend self
end
