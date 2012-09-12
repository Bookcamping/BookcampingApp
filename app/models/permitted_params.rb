class PermittedParams < Struct.new(:params, :user)
  def self.permit(*names)
    names.each do |name|
      define_method(name) do
        result = self.send("#{name}_attributes")
        params.require(name).permit(*result)
      end
    end
  end

  permit :library, :shelf

  def library_attributes
    [:name, :slug, :description]
  end

  def shelf_attributes
    [:name, :slug, :description]
  end

  def reference_attributes

  end


end
