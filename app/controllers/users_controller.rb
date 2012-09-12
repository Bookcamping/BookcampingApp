class UsersController < ApplicationController
  respond_to :html
  expose(:order) do
    column = params[:o].present? ? params[:o] : 'name'
    order = params[:d] == 'asc' ? 'ASC' : 'DESC'
    "#{column} #{order}"
  end
  expose(:users) { User.reorder(order) }
  expose(:user) 

  def index
    index!(user)
  end

  def show
    show!(user)
  end
end
