
class StaticController < ApplicationController
  def sitemap
    respond_to do |format|
      format.text
    end
  end

  def data
    render json: Tagging.all.to_json
  end
end
