class EmailsController < ApplicationController
  def test
    UserMailer.test_mail('danigb@gmail.com').deliver
    render text: 'Email enviado'
  end

  def activity
    @library = Library.find params[:id]
  end

  def notifications
    @notifications = Notification.where(mail_pending: true)
  end
end
