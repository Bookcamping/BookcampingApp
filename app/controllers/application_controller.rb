# ApplicationController
class ApplicationController < ActionController::Base
  expose(:current_library) { Library.first }
  expose(:current_user) { nil }

  protect_from_forgery
end
