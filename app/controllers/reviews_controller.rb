class ReviewsController < ApplicationController
  expose(:reference) { Reference.find(params[:reference_id]) }
  expose(:reviews) { reference.reviews }
  expose(:review) 

  def new
    new!(review)
  end
end
