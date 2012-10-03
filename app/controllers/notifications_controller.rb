class NotificationsController < ApplicationController
  expose(:user) { User.find params[:user_id] }
  expose(:notifications) { user.notifications }

  def index
    index!(Notification)
  end
end
