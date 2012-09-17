# encoding: utf-8
module Site
  class Tab < Struct.new(:label, :path)
  end

  def host
    Rails.env.production? ? 'bookcamping.cc' : 'localhost:300o'
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
      Tab.new('Inicio', '/'),
      Tab.new('Blog', 'http://blog.bookcamping.cc'),
      Tab.new('Mapa', '/mapa'),
      Tab.new('¿Cómo?', '/como')
    ]
    @tabs
  end

  extend self
end
