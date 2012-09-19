require 'test_helper'

describe Recommendation do
  it 'destroys version when destroyed' do
    user = create(:user)
    reference = create(:reference)
    recommendation = user.recommend(reference)
    recommendation.must_be :present?
    Version.where(item_type: 'Recommendation').count.must_equal 1
    recommendation.destroy
    Version.where(item_type: 'Recommendation').count.must_equal 0
  end

end
