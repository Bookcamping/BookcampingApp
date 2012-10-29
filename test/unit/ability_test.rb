require 'test_helper'

describe Ability do
  describe "Ability without user" do
    let(:ability) { Ability.new(nil, nil) }

    it "read librares" do
      ability.can?(:read, create(:library)).must_equal true
    end
  end

  describe "Ability with user" do
    let(:user) { create(:user) }
    let(:ability) { Ability.new(user, nil) }

    it "update library if member" do
      library = create(:library)
      library.add_member(user)
      ability.can?(:update, library).must_equal true
    end
  end

  describe "Ability with user and library" do
    let(:user) { create(:user) }
    let(:library) { create(:library) }
    let(:ability) { Ability.new(user, library) }

    it "can't create shelves if library protected" do
      library.update_attribute(:protected, true)
      ability.can?(:create, Shelf).must_equal false
    end
  end

  describe "Visitas guiadas" do
    let(:user) { create(:user) }
    let(:library) { create(:library, user: user, ltype: 'guides') }
    let(:ability) { Ability.new(user, nil) }

    it 'can create shelfitems' do
      ab = Ability.new(user, library)
      ab.can?(:create, ShelfItem).must_equal true
    end

    it 'can edit guide' do
      ref = create(:reference)
      shelf = create(:shelf, library: library)
      item = shelf.add_reference(ref, user)
      ability.can?(:update, item).must_equal true
    end
  end
end
