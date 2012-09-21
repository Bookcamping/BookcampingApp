module ResourceTestHelper

  def must_include_resource(model, options = {}) 
    attributes = extract_attribute_names(model, options)
    attributes.each do |attribute|
      page.text.must_include model.send(attribute).to_s
    end
  end

  def fill_in_resource(model, options = {}) 
    attributes = extract_attribute_names(model, options)
    attributes.each do |attribute| 
      field = "#{model.class.to_s.downcase}_#{attribute}"
      fill_in field, with: model.send(attribute)
    end
  end

  def must_equal_resource(resource, expected, options = {})
    attributes = extract_attribute_names(resource, options)
    resource.must_be :present?
    attributes.each do |attribute|
      resource.send(attribute).must_equal expected.send(attribute)
    end
  end

  protected
  def extract_attribute_names(model, options)
    options[:only] ||= model.attribute_names.map(&:to_sym) - [:id, :created_at, :updated_at]
    options[:only]
  end
end
