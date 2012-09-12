class SessionsController < ApplicationController
  expose(:redirect_url) { params[:from].present? ? params[:from] : '/'}
  expose(:omniauth) { request.env['omniauth.auth'] }
  expose(:user)  { User.new }

  def new
    if current_user?
      redirect_to user_path(current_user)
    else
      store_location(params[:from]) if params[:from].present?
      redirect_to "/auth/#{params[:id]}" if params[:id].present?
    end
  end


  def create_with_omniauth
    user = User.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])

    if user
      login_with(user)
    else
      @user = User.new do |nu|
        nu.name = omniauth['info']['name']
        nu.email = omniauth['info']['email']
        nu.twitter = omniauth['info']['nickname']
        column = "uid_#{omniauth['provider']}="
        nu.send(column, omniauth['uid'])
      end
      login_with(@user) if @user.save
    end
  end

  def create
    user = User.find_by_email(permitted_params.user[:email])
    if user
      if user.authenticate(permitted_params.user[:password])
        login_with(user)
      else
        redirect_to login_path, alert: t('sessions.auth_failed')
      end
    else
      redirect_to login_path, alert: t('sessions.user_not_found')
    end
  end

  def destroy
    store_location(params[:from]) if params[:from]
    clear_user
    redirect_to stored_or(root_url), :notice => t('sessions.signed_out')
  end

  def enter
    if not Rails.env.production? or (current_user and current_user.super?)
      self.current_user = User.find params[:id]
    end
    redirect_to stored_or(root_path)
  end

  def failure
    redirect_to login_path, notice: t('sessions.login_failure') 
  end

  protected
  def login_with(user)
    self.current_user = user
    user.audit_login
    redirect_to stored_or(root_path), notice:
      t('sessions.login_success', name: user.name)
  end
end
