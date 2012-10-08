require 'test_helper'

describe Repub do
  it 'reference is repubbed when created' do
    ref = create(:reference)
    repub = create(:repub, reference: ref)
    ref.repubbed?.must_equal true
  end

  it 'reference is not repubbed when destroyed' do
    ref = create(:reference)
    repub = create(:repub, reference: ref)
    repub.destroy
    ref.repubbed?.must_equal false
  end
end
