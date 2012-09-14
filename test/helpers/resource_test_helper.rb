module ResourceTestHelper

  def must_include(model, attributes) 
    attributes.each do |attribute|
      page.must_include model.send(attribute)
    end
  end
end
