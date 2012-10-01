class DashboardsController < ApplicationController

  expose(:user) { User.new }
  expose(:libraries) { Library.all }
  expose(:most_active_shelves) { Shelf.reorder('updated_at DESC').limit(10) }
  expose(:site_activity) { Activity.new(Site, per_page: 10) }
  expose(:latest_references) { Search::References.new(limit: 10) }
  def site
  end

  expose(:search_term) { params[:term] if params[:term].present? }
  expose(:search_references) do
    if search_term
      Reference.search(search_term)
    else
      []
    end
  end
  def search
  end

  def queue
  end
end
