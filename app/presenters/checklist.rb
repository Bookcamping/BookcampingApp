class Checklist
  def initialize(view_context)
    @h = view_context
    @checks = {}
  end

  def needs(name, options)
    options.reverse_merge! if: false, visible: true
    @checks[name] = options
  end

  def item(name, path, label = nil)
    if visible?(name)
      label ||= I18n.t("references.checklist.#{name}")
      label = @h.icon('arrow-right', label)
      content = check?(name) ? @h.link_to(label, path) : 
        @h.raw("<del>#{label}</del>")
      @h.content_tag :li, content, class: 'check-item'
    end
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
