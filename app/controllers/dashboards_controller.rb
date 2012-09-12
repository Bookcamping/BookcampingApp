class DashboardsController < ApplicationController

  expose(:user) { User.new }
  expose(:libraries) { Library.all }
  def site

  end
end
