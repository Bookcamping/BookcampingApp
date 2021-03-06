# encoding: utf-8

class NotifyMailer < ActionMailer::Base
  default from: 'hola@bookcamping.cc'

  layout 'mail'

  def shelf_created(shelf, user)
    @shelf = shelf
    @user = user
    mail to: user.email, subject: 'Tenemos una nueva estantería'
  end

  def shelf_item_created(item, user)
    @item = item
    @shelf = item.shelf
    @user = user
    mail to: user.email, subject: 'Estantería modificada'
  end

  def reference_updated(reference, user)
    logger.info "NotifyMailer::reference_updated to #{user.email}"
    @user = user
    @reference = reference
    mail to: user.email, subject: 'Una referencia ha sido modificada'
  end
end
