# encoding: utf-8
module Site
  class Tab < Struct.new(:label, :path)
  end

  def featured_libraries
    Library.where(featured: true).order('created_at ASC')
  end

  def featured_guided_shelves
    Shelf.where(featured: true).where(visualization: 'visit')
  end

  def featured_published_reference
    Reference.where(featured: true).order('updated_at DESC').first
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

  def notifications
    Notification.reorder('id DESC').limit(40)
  end

  def versions
    Version.scoped
  end

  extend self
end
