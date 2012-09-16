class UsersController < ApplicationController
  respond_to :html
  expose(:order) do
    column = params[:o].present? ? params[:o] : 'name'
    order = params[:d] == 'asc' ? 'DESC' : 'ASC'
    "#{column} #{order}"
  end
  expose(:users) { User.reorder(order) }
  expose(:active_users) { User.where('versions_count > 0') }
  expose(:user) 
  expose(:user_activity) { Activity.new(user) }

  def index
    index!(User)
  end

  def dashboard
    authorize! :manage, User
    respond_with users
  end

  def show
    show!(user)
  end

  def update
    update!(user, :user)
  end
end
