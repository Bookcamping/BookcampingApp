module ApplicationHelper
  def title(title, tag = :h1)
    content_for(:title) { title }
    content_tag tag, title
  end

  def renderer
    unless @renderer
      options = {hard_wrap: true, autolink: true, fenced_code_blocks: true }
      @renderer = Redcarpet::Markdown.new(Redcarpet::Render::HTML, options)
    end
    @renderer
  end

  def clean_renderer
    unless @clean_renderer
      options = {hard_wrap: true, autolink: true, fenced_code_blocks: true }
      @clean_renderer = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(filter_html: true), options)
    end
    @clean_renderer
  end

  def markdown(text, options = {})
    options.reverse_merge length: nil
    text = ' ' if text.blank?
    text = truncate(text, length: options[:length]) if options[:length]
    ren = options[:clean] == true ? clean_renderer : renderer
    rendered = ren.render(text)
    content_tag(:div, rendered.html_safe, :class => 'markdown')
  end

  # Translate collection
  def tc(prefix, collection)
    collection.map do |item|
      [I18n.t("#{prefix}.#{item}"), item]
    end
  end

  def icon(icon, label = nil)
    label = label.present? ? h("#{label}") : ''
    raw("<i class='icon-#{icon}'></i>&nbsp;#{label}")
  end

  def simple_debug(model)
    content_for(:debug) { debug(model) } if Rails.env.development?
  end

  def debug_resource_errors(model)
    if Rails.env.development?
      debug(model.errors)
    elsif Rails.env.test? && model.errors.count > 0
      puts "MODEL ERRORS #{model.errors.inspect}"
    end
  end

  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", form: builder)
    end
    link_to(name, '#', class: "add_fields action", 
            data: {id: id, fields: fields.gsub("\n", ""), css: association})
  end
end
