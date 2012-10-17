module ReferenceHelper
  def reference_color(shelf)
    shelf ? shelf.color : '#AAA'
  end

  def reference_checklist(reference, &block)
    checklist = ReferenceChecklist.new(reference, self)
    yield checklist if block_given? && !checklist.completed?
    checklist
  end

  def reference_css_class(reference) 
    case reference.ref_type
    when 'WebPage'
      'WebPage'
    when 'Video'
      'Video'
    when 'Audio'
      'Audio'
    else
      'Book'
    end
  end

end
