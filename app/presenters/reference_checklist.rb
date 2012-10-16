  class ReferenceChecklist
    def initialize(reference, view_context)
      @h = view_context
      @reference = reference
    end

    def item(name, path, label = nil)
      label ||= I18n.t("references.checklist.#{name}")
      label = @h.icon('arrow-right', label)
      content = check?(name) ? @h.link_to(label, path) : 
        @h.raw("<del>#{label}</del>")
      @h.content_tag :li, content, class: 'check-item'
    end

    def description?
      @reference.description.blank?
    end

    def visible?
      true
    end

    def tags?
      @reference.tag_names.blank?
    end

    def download?
      @reference.libre? && @reference.downloads_count == 0
    end

    protected 
    def check?(name)
      self.send("#{name}?")
    end
  end

