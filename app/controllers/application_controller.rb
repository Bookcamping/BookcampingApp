# ApplicationController
class ApplicationController < ActionController::Base
  protect_from_forgery
  respond_to :html

  include HasCurrentUser
  helper_method :current_user, :current_user?

  include HasResource

  expose(:current_library) { nil }
  expose(:permitted_params) { PermittedParams.new(params, current_user) }

  def info_for_paper_trail
    { user_name: (current_user? ? current_user.name : t('user.anonymous')) }
  end

  rescue_from CanCan::AccessDenied do |exception|
    if current_user
      redirect_to root_url, :notice => t('access_denied.no_privilegies')
    else
      redirect_to root_url, :notice => t('access_denied.no_user')
    end
  end

end
