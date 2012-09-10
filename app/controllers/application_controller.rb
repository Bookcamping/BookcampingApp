# ApplicationController
class ApplicationController < ActionController::Base
  expose(:current_library) { Library.first }
  expose(:current_user) { nil }
  expose(:permitted_params) { PermittedParams.new(params, current_user) }

  protect_from_forgery
end
