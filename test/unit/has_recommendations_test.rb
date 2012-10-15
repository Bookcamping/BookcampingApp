require 'test_helper'

describe HasRecommendations do
  it 'can recommend' do
    user = create(:user)
    reference = create(:reference)

    user.recommend(reference).must_be :present?
    user.recommended.must_include reference
  end
end
