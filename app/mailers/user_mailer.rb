class UserMailer < ActionMailer::Base
  default from: "hola@bookcamping.cc"
  layout 'mail'
  default_url_options[:host] = Site.host

  def recovery_password(user_id)
    @user = User.find user_id
    if @user.email.present?
      @host = Site.host
      @title = I18n.t('user_mailer.recovery_password')
      mail to: @user.email, subject: @title
    end
  end
end

