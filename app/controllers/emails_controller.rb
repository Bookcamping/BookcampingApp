class EmailsController < ApplicationController
  before_filter :require_user, only: :test

  def test
    UserMailer.test_mail(current_user).deliver
    render text: 'Email enviado'
  end

  def activity
    @library = Library.find params[:id]
  end

  def notifications
    @notifications = Notification.where(mail_pending: true)
    unless params[:test].present?
      @notifications.each do |notification|
        UserMailer.notification(notification).deliver
      end
    end
  end
end
