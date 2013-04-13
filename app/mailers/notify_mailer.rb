# encoding: utf-8

class NotifyMailer < ActionMailer::Base
  def shelf_created(shelf, user)
    @shelf = shelf
    @user = user
    mail to: user.email, subject: 'Tenemos una nueva estantería'
  end

  def shelf_item_created(item, user)
    @item = item
    @user = user
    mail to: user.email, subject: 'Estantería modificada'
  end
end
