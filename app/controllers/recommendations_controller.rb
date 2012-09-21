class RecommendationsController < ApplicationController
  before_filter :require_user, except: [:show, :index]
  expose(:reference) { Reference.find(params[:r]) }
  expose(:versions) { Version.where(item_type: 'Recommendation').
                      order('created_at ASC').limit(40) }

  def index
  end

  def show
    redirect_to Recommendation.find(params[:id]).reference
  end

  def create
    recommendation = current_user.recommend(reference)
    flash[:notice] = t('recommendations.created', title: reference.title)
    respond_with recommendation, location: reference
  end

  def destroy
    recommendation = current_user.recommendations.find params[:id]
    reference = recommendation.reference
    recommendation.destroy
    flash[:notice] = t('recommendations.destroyed', title: reference.title)
    respond_with recommendation, location: reference
  end
end
