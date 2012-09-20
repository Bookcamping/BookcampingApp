class DashboardsController < ApplicationController

  expose(:user) { User.new }
  expose(:libraries) { Library.all }
  expose(:most_active_shelves) { Shelf.reorder('updated_at DESC').limit(10) }
  expose(:site_activity) { Activity.new(Site, per_page: 10) }
  expose(:search) { Search::References.new(limit: 10) }

  def site

  end
end
