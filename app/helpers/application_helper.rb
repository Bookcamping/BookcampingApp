module ApplicationHelper
  def title(title)
    content_for(:title) { title }
    content_tag :h1, title
  end

  def renderer
    unless @renderer
      options = {hard_wrap: true, autolink: true, fenced_code_blocks: true }
      @renderer = Redcarpet::Markdown.new(Redcarpet::Render::HTML, options)
    end
    @renderer
  end

  def markdown(text, options = {})
    options.reverse_merge length: nil
    text = ' ' if text.blank?
    text = truncate(text, length: options[:length]) if options[:length]
    rendered = renderer.render(text)
    content_tag(:div, (rendered+'<br/>').html_safe, :class => 'markdown')
  end

  # Translate collection
  def tc(prefix, collection)
    collection.map do |item|
      [I18n.t("#{prefix}.#{item}"), item]
    end
  end

  def simple_debug(model)
    debug(model) if Rails.env.development?
  end

  def debug_resource_errors(model)
    if Rails.env.development?
      debug(model.errors)
    elsif Rails.env.test? && model.errors.count > 0
      puts "MODEL ERRORS #{model.errors.inspect}"
    end
  end
end
