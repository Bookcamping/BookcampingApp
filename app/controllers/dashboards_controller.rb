class DashboardsController < ApplicationController

  expose(:libraries) { Library.all }
  def site

  end
end
