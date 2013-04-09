# encoding: utf-8

class UserMailer < ActionMailer::Base
  default from: "hola@bookcamping.cc"
  layout 'mail'

  default_url_options[:host] = Site.host

  def test_mail(user_recipient)
    prepare_notification(Notification.last)
    mail(to: user_recipient.email, subject: @title) do |format|
      format.html { render 'notification' }
    end
  end

  def shelf_created(shelf, user)
    @shelf = shelf
    @user = user
    mail to: user.email, subject: 'Tenemos una nueva estantería'
  end

  def notification(notification)
    prepare_notification(notification)
    mail to: notification.user.email, subject: @title
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
    @version = notification.version
    @user = @version.user
    if @version.item
      @reference = @version.item.reference
      @shelf = @version.item.shelf
    end
    @user_name = @user ? @user.name : I18n.t('app.anonymous')
    @title = I18n.t('user_mailer.notification', user: @user_name,
                    model: @version.shelf.name)
    @notification.update_attribute(:mail_pending, false)
  end
end

