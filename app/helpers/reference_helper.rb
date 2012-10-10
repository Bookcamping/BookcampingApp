module ReferenceHelper
  def reference_color(shelf)
    shelf ? shelf.color : '#AAA'
  end

  def reference_checklist(reference, &block)
    checklist = ReferenceCheckList.new(reference)
    yield checklist if block_given? && checklist.visible?
    checklist
  end

  class ReferenceCheckList
    def initialize(reference)
      @reference = reference
    end

    def visible?
      false
    end

    def tags?
      @reference.tag_names.blank?
    end

    def downloads?
      true
    end
  end
end
