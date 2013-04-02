module HasCurrentLibrary 
  extend ActiveSupport::Concern

  included do
    expose(:current_library) { nil }
  end
end

