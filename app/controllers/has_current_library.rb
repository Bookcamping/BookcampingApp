module HasCurrentLibrary 
  extend ActiveSupport::Concern

  included do
    expose(:current_library) { load_current_library }
  end

  protected 
  def load_current_library
    subdomain = request.subdomain
    puts "SUBDOMAIN: #{subdomain} #{request.host}"

    if subdomain.present? && subdomain != 'www'
      Library.find subdomain
    else
      nil
    end
  end
end

