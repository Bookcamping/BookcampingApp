module ReferenceHelper
  def reference_color(shelf)
    shelf ? shelf.color : '#AAA'
  end

  def reference_checklist(reference, &block)
    checklist = ReferenceChecklist.new(reference, self)
    yield checklist if block_given? && !checklist.completed?
    checklist
  end

end
