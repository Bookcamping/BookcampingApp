require 'test_helper'

describe Ability do
  describe "Ability without user" do
    let(:ability) { Ability.new(nil) }

    it "read librares" do
      ability.can? :read, create(:library)
    end
  end

  describe "Ability with user" do
    let(:user) { create(:user) }
    let(:ability) { Ability.new(user) }

    it "update library if member" do
      library = create(:library)
      library.add_member(user)
      ability.can? :update, library
    end
  end
end
