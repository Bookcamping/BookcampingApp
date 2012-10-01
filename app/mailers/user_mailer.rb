class UserMailer < ActionMailer::Base
  default from: "hola@bookcamping.cc"
  layout 'mail'

  default_url_options[:host] = Site.host

  def test_mail(to)
    mail to: to, subject: 'Probando'
  end

  def shelf_activity(shelf, version, user)
    @shelf = shelf
    @version = version
    @user = user
    @title = I18n.t('user_mailer.shelf_activity')
    mail to: @user.email, subject: @title
  end

  def recovery_password(user_id)
    @user = User.find user_id
    if @user.email.present?
      @host = Site.host
      @title = I18n.t('user_mailer.recovery_password')
      mail to: @user.email, subject: @title
    end
  end
end

