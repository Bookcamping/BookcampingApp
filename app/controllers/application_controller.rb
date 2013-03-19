# ApplicationController
class ApplicationController < ActionController::Base
  protect_from_forgery
  respond_to :html

  include HasCurrentUser
  helper_method :current_user, :current_user?

  include HasResource
  include HasCurrentLibrary

  expose(:permitted_params) { PermittedParams.new(params, current_user) }
  expose(:layout_row) { 'basic' }

  def info_for_paper_trail
    { 
      user_id: (User.current ? User.current.id : nil),
      user_name: (User.current ? User.current.name : I18n.t('app.anonymous')) 
    }
  end

  def current_ability
    @current_ability ||= Ability.new(current_user, current_library)
  end

  rescue_from CanCan::AccessDenied do |exception|
    if Rails.env.test?
      raise exception
    else
      if current_user
        redirect_to root_url, :alert => t('access_denied.no_privilegies')
      else
        redirect_to login_url, :alert => t('access_denied.no_user')
      end
    end
  end

  helper_method :view_shelf_path
  def view_shelf_path(shelf, reference = nil)
    options = { library: shelf.library }
    options[:anchor] = "ver-#{reference.to_param}" if reference.present?
    shelf_path(shelf, options)
  end

end
