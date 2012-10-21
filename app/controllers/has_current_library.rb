module HasCurrentLibrary 
  extend ActiveSupport::Concern

  included do
    expose(:current_library) { load_current_library }
  end

  protected 
  def load_current_library
    subdomain = request.subdomain

    if subdomain.present?
      Library.find subdomain
    else
      nil
    end
  end
end

