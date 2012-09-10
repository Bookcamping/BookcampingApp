class UsersController < ApplicationController
  respond_to :html
  expose(:users) { User.all }
  expose(:user) 

  def show
    respond_with user
  end
end
