class DashboardsController < ApplicationController
  expose(:layout_row) { params[:action] == 'welcome' ? nil : 'basic' }

  expose(:user) { User.new }
  expose(:libraries) { Library.scoped }
  expose(:most_active_shelves) { Shelf.reorder('updated_at DESC').limit(10) }
  expose(:site_activity) { Activity.activity(Version.scoped, limit: 10).scoped }
  expose(:latest_references) { Scope.new(Reference.scoped, limit: 10).scoped }
  expose(:tags) { Tag.reorder('taggings_count DESC').limit(100) }
  def site
  end

  def welcome
  end

  def library
  end

  def test_email
    require_admin
    Notifier.perform_async(:test_email, :create, nil)
    redirect_to root_path
  end

  expose(:published_references) { Reference.where('downloads_count > 0') }
  def published
  end

  expose(:srch) { Search.new(params[:term]) }
  expose(:search_term) { srch.term }
  expose(:references_search) { srch.references }
  expose(:shelves_search) { srch.shelves }
  expose(:tags_search) { srch.tags }
  def search
  end
end
