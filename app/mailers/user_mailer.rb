class UserMailer < ActionMailer::Base
  default from: "hola@bookcamping.cc"
  layout 'mail'

  default_url_options[:host] = Site.host

  def test_mail(user_recipient)
    prepare_notification(Notification.last)
    mail to: user_recipient.email, subject: @title
  end

  def notification(notification)
    prepare_notification(notification)
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

  protected
  def prepare_notification(notification)
    @notification = notification
    @user = notification.user
    @version = notification.version
    @title = I18n.t('user_mailer.notification', user: @user.name, 
                    model: @version.shelf.name)
  end
end

