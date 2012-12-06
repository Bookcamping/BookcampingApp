class DashboardsController < ApplicationController

  expose(:user) { User.new }
  expose(:libraries) { Library.scoped }
  expose(:most_active_shelves) { Shelf.reorder('updated_at DESC').limit(10) }
  expose(:site_activity) { Activity.activity(Version.scoped, limit: 10).scoped }
  expose(:latest_references) { Scope.new(Reference.scoped, limit: 10).scoped }
  def site
  end

  def library

  end

  expose(:srch) { Search.new(params[:term]) }
  expose(:search_term) { srch.term }
  expose(:references_search) { srch.references }
  expose(:shelves_search) { srch.shelves }
  expose(:tags_search) { srch.tags }
  def search
  end
end
