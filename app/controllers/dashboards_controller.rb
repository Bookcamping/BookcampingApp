class DashboardsController < ApplicationController

  expose(:user) { User.new }
  expose(:libraries) { Library.all }
  expose(:most_active_shelves) { Shelf.reorder('updated_at DESC').limit(10) }
  expose(:site_activity) { Search::Versions.new(Site, per_page: 10) }
  expose(:latest_references) { Search::References.new(limit: 10) }
  def site
  end

  expose(:search_term) { params[:term] if params[:term] && params[:term].length > 3 }
  expose(:references_search) do
    Reference.search_by_title_or_authors_or_editor(search_term, search_term, search_term) if search_term.present?
  end

  expose(:shelves_search) do
    Shelf.search_by_name(search_term) if search_term.present? 
  end

  expose(:tags_search) do
    Tag.search_by_name(search_term) if search_term.present?
  end

  def search
  end

  def queue
  end
end
