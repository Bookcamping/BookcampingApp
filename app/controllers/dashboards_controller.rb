class DashboardsController < ApplicationController

  expose(:user) { User.new }
  expose(:libraries) { Library.all }
  expose(:most_active_shelves) { Shelf.reorder('updated_at DESC').limit(10) }
  expose(:site_activity) { Activity.new(:site, per_page: 10) }
  expose(:recent_references) { Reference.reorder('created_at DESC').limit(10) }

  def site

  end
end
