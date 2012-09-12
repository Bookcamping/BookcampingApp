class PermittedParams < Struct.new(:params, :user)
  def self.permit(*names)
    names.each do |name|
      define_method(name) do
        result = self.send("#{name}_attributes")
        params.require(name).permit(*result)
      end
    end
  end

  permit :library, :shelf, :reference, :user

  def library_attributes
    [:name, :slug, :description]
  end

  def shelf_attributes
    [:name, :slug, :description]
  end

  def reference_attributes

  end

  def user_attributes
    [:name, :email, :password, :password_confirmation, 
     :twitter, :description, :uid_twitter, :uid_facebook, :uid_google]
  end


end
