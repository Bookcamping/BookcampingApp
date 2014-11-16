module LinkHelper
  MIME_TYPES = %w(.pdf .epub .jpg .jpeg .png)
  REGEX_MIME_TYPES = [/\.pdf/, /\.epub/, /\.jpg/, /\.png/]

  def link_description(reference, link)
    mime = MIME_TYPES.select {|t| link.index(t) != nil }
    mime.size > 0 ? "Descargar (#{mime[0]})" : "#{link_prefix(reference)} <span class='domain'>(#{base_link(link)})</span>".html_safe
  end

  def link_prefix(reference)
    I18n.t("references.downloads.#{reference.ref_type}")
  end

  def base_link(url)
    parts = url.split('/')
    parts.shift while parts[0] =~ /^http/
    parts.shift while parts[0] =~ /^\s*$/
    parts[0]
  end

end
