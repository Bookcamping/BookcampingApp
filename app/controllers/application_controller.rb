# ApplicationController
class ApplicationController < ActionController::Base
  protect_from_forgery
  respond_to :html

  include HasCurrentUser
  helper_method :current_user, :current_user?

  include HasResource

  expose(:current_library) { Library.first }
  expose(:permitted_params) { PermittedParams.new(params, current_user) }


end
