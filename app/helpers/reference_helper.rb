module ReferenceHelper
  def reference_color(shelf)
    shelf ? shelf.color : '#AAA'
  end

  def cover_image?(reference)
    reference && cover_image(reference).present? 
  end

  def cover_image(reference)
    reference.downloads.first.try(:cover_image)
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
