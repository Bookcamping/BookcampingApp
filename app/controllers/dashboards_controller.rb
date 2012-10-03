class DashboardsController < ApplicationController

  expose(:user) { User.new }
  expose(:libraries) { Library.all }
  expose(:most_active_shelves) { Shelf.reorder('updated_at DESC').limit(10) }
  expose(:site_activity) { Search::Versions.new(Site, per_page: 10) }
  expose(:latest_references) { Search::References.new(limit: 10) }
  def site
  end

  expose(:refsearch) { Search::References.search(params[:term]) }
  def search
  end

  def queue
  end
end
