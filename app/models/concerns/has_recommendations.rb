module HasRecommendations
  extend ActiveSupport::Concern

  included do
    has_many :recommendations, dependent: :destroy
    has_many :recommended, through: :recommendations, 
      source: :reference, class_name: 'Reference'
  end

  def recommendation(reference)
    Recommendation.where(user_id: self.id, 
                         reference_id: reference.id).first
  end

  def recommend(reference)
    return nil if reference.blank?
    r = Recommendation.new(user_id: self.id, 
                           reference_id: reference.id)
    r.save ? r : nil
  end

  def unrecommend(reference)
    recommendation(reference).try(:destroy)
  end
end
