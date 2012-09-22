class ActivitiesController < ApplicationController
  respond_to :html, :js
  expose(:parent) do
    if params[:shelf_id].present?
      Shelf.find params[:shelf_id]
    else
      Site
    end
  end
  expose(:activity) { Activity.new(parent, page: params[:p], per_page: 30) }

  def show
    show!(activity)
  end
end
