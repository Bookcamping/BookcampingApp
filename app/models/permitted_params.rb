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
  permit :membership

  def library_attributes
    [:name, :slug, :description, :shelf_name, :logo, :slogan, :question]
  end

  def shelf_attributes
    [:name, :description]
  end

  def reference_attributes
  end

  def user_attributes
    [:name, :email, :password, :password_confirmation, 
     :twitter, :description, :uid_twitter, :uid_facebook, :uid_google]
  end

  def membership_attributes
    [:resource_type, :resource_id, :user_name]
  end

  def shelf_item
    params.permit([:s, :r])
  end
end
