class Checklist
  def initialize(view_context)
    @h = view_context
    @checks = {}
  end

  def needs(name, options)
    options.reverse_merge! if: false, visible: true
    @checks[name] = options
  end

  def item(name, path, options = {})
    options.reverse_merge! icon: 'arrow-right',
      label: I18n.t("references.checklist.#{name}")

    if visible?(name)
      label ||= I18n.t("references.checklist.#{name}")
      label = @h.icon(options[:icon], label)
      content = check?(name) ? @h.link_to(label, path) : 
        @h.raw("<del>#{label}</del>")
      @h.content_tag :li, content, class: 'check-item'
    end
  end

  def link(name, path, options = {})
    options.reverse_merge! icon: 'arrow-right',
      label: I18n.t("references.checklist.#{name}")

    label = @h.icon(options[:icon], options[:label])
    @h.content_tag :li, @h.link_to(label, path), class: 'check-item'
  end

  def completed?
    false
  end

  protected 
  def check?(name)
    @checks[name][:if]
  end

  def visible?(name)
    @checks[name][:visible]
  end
end
