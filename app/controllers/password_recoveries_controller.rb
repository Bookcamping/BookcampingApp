# Permite cambiar la contraseña.
class PasswordRecoveriesController < ApplicationController
  expose(:password_recovery)
  expose(:recover_user) { User.find_by_recovery_code!(params[:id]) }

  # Formulario para poner tu email
  def new
  end

  # Muestra el mensaje de que se te ha enviado un email (en caso
  # de que se haya encontrado ese email entre lxs usuarixs)
  def show
  end

  # Crea el PasswordRecovery y muestra el resultado (mediante show)
  def create
    password_recovery.save
    render action: 'show'
  end

  # Muestra el formulario para cambiar de contraseña
  def recover
  end

  # La acción del formulario para cambiar de contraseña
  def change
    user = User.find params[:user_id]
    if params[:password].present?
      user.update_attributes(password: params[:password], password_confirmation: params[:password])
      user.destroy_recovery_code
      redirect_to login_path, notice: t('password_recoveries.changed')
    else
      redirect_to change_password_recoveries_path(identity.ui), notice: t('password_recoveries.required')
    end
  end


end

