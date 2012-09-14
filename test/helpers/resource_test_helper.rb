module ResourceTestHelper

  def must_include_resource(model, options = {}) 
    attributes = extract_attribute_names(model, options)
    attributes.each do |attribute|
      page.text.must_include model.send(attribute)
    end
  end

  def fill_in_resource(model, options = {}) 
    attributes = extract_attribute_names(model, options)
    attributes.each do |attribute| 
      fill_in "#{model.class.to_s.downcase}_#{attribute}", 
        with: model.send(attribute)
    end
    click_submit
    last = model.class.last
    last.must_be :present?
    attributes.each do |attribute|
      last.send(attribute).must_equal model.send(attribute)
    end
  end

  protected
  def extract_attribute_names(model, options)
    options[:only]
  end
end
