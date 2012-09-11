# ApplicationController
class ApplicationController < ActionController::Base
  protect_from_forgery
  respond_to :html

  expose(:current_library) { Library.first }
  expose(:current_user) { nil }
  expose(:permitted_params) { PermittedParams.new(params, current_user) }

  protected
  def show!(model)
    authorize! :show, model
    respond_with model
  end

end
