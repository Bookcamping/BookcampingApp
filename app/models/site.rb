# encoding: utf-8
module Site
  class Tab < Struct.new(:label, :path)
  end

  def visible_libraries
    @visible_libraries ||= [6, 2, 1].map {|id| Library.find(id) }
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
      Tab.new('Blog', 'http://blog.bookcamping.cc'),
      Tab.new('Somos', '/somos'),
      Tab.new('Mapa', '#'),
      Tab.new('¿Cómo?', '/como')
    ]
    @tabs
  end

  extend self
end
