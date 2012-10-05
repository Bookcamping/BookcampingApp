class NotificationsController < ApplicationController
  expose_parent [:user], default: Site
  expose(:user) { User.find params[:user_id] }
  expose(:notifications) { parent.notifications }

  def index
    index!(Notification)
  end
end
