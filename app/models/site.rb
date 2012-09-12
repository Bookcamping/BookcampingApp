# encoding: utf-8
module Site
  class Tab < Struct.new(:label, :path)
  end

  def footer_links
    {
      'Agradecimientos enormes' => '#',
      'Contactar' => '#',
      'Sobre nosotras' => '#'
    }
  end

  def tabs
    @tabs ||= [
      Tab.new('Estantes', '/estanterias'),
      Tab.new('Listas', '/listas'),
      Tab.new('Blog', 'http://blog.bookcamping.cc'),
      Tab.new('¿Cómo?', '#')
    ]
    @tabs
  end

  extend self
end
