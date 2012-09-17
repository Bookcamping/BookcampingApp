class ActivitiesController < ApplicationController
  expose(:parent) do
    if params[:shelf_id].present?
      Shelf.find params[:shelf_id]
    else
      Site
    end
  end
  expose(:activity) { Activity.new(parent) }

  def show
    show!(activity)
  end
end
