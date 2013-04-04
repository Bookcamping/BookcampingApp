class PermittedParams < Struct.new(:params, :user)
  def self.permit(*names)
    names.each do |name|
      define_method(name) do
        permitted = self.send("#{name}_attributes")
        params.require(name).permit(*permitted)
      end
    end
  end

  permit :library, :shelf, :reference, :user
  permit :version, :download, :license, :link

  def library_attributes
    attributes = [:name, :slug, :description, :shelf_name, :logo, :slogan, :question]
    attributes << :library_id # TODO: add conditions
    attributes
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

  def shelf_item
    params.permit([:s, :r])
  end

  def version_attributes
    [:whodunnit, :title]
  end

  def link_attributes
    [:url, :description]
  end

  def download_attributes
    [:url, :description, :file, :cover_image, :content_type]
  end

  def license_attributes
    [:name, :libre, :url, :license_type]
  end
end
