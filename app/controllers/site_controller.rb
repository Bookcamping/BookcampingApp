class SiteController < ApplicationController
  layout false

  caches_page :map

  def map; end
end
