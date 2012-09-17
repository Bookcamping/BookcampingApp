class DashboardsController < ApplicationController

  expose(:user) { User.new }
  expose(:libraries) { Library.all }
  expose(:most_active_shelves) { Shelf.reorder('updated_at DESC').limit(10) }
  expose(:site_activity) { Activity.new(Site, per_page: 10) }
  expose(:recent_references) { Reference.where('created_at is not null').reorder('created_at DESC').limit(10) }

  def site

  end
end
