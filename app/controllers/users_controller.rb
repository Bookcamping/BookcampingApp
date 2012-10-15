class UsersController < ApplicationController
  expose(:order) do
    column = params[:o].present? ? params[:o] : 'name'
    order = params[:d] == 'asc' ? 'DESC' : 'ASC'
    "#{column} #{order}"
  end
  expose(:users) { User.reorder(order) }
  expose(:active_users) { users.where('versions_count > 0') }
  expose(:user) 
  expose(:user_activity) { Activity.activity(user.versions).scoped }

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

  def create
    create!(user, :user) do
      self.current_user = user
      user.audit_login
      root_path
    end
  end

  def update
    update!(user, :user)
  end

end
