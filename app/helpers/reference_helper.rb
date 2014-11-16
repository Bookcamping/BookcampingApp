module ReferenceHelper
  def reference_color(shelf)
    shelf ? shelf.color : '#AAA'
  end

  MIME_TYPES = %w(.pdf .epub .jpg .jpeg .png)
  def url_description(reference, url)
    mime = MIME_TYPES.select {|t| url.index(t) != nil }
    mime.size > 0 ? "Descargar (#{mime[0]})" : "#{url_prefix(reference)} <span class='domain'>(#{base_url(url)})</span>".html_safe
  end

  def url_prefix(reference)
    I18n.t("references.downloads.#{reference.ref_type}")
  end

  def base_url(url)
    parts = url.split('/')
    parts.shift while parts[0] =~ /^http/
    parts.shift while parts[0] =~ /^\s*$/
    parts[0]
  end


  def reference_checklist(reference, &block)
    checklist = ReferenceChecklist.new(reference, self)
    yield checklist if block_given? && !checklist.completed?
    checklist
  end

  def reference_css_class(reference, extra = nil)
    type = case reference.ref_type
    when 'WebArticle', 'WebPage', 'Blog', 'Post', 'Site'
      'WebPage'
    when 'Video'
      'Video'
    when 'Audio'
      'Audio'
    else
      'Book'
    end
    extra ? "#{type} #{extra}" : type
  end

end
