# encoding: utf-8
module Site
  class Tab < Struct.new(:label, :path)
  end

  def visible_libraries
    {
      'Listas compartidas' => '/listas',
      'Videocamping' => '/videoclub',
      'Bookcamping' => '/estanterias'
    }
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
      Tab.new('Estantes', '/estanterias'),
      Tab.new('Listas', '/listas'),
      Tab.new('Blog', 'http://blog.bookcamping.cc'),
      Tab.new('¿Cómo?', '/como')
    ]
    @tabs
  end

  extend self
end
