require 'test_helper' 

describe Library do
  it "must have name" do
    library = create(:library)
    library.name.must_be :present?
  end

  it "have owner member" do
    library = create(:library)
    library.members.must_include library.user
  end

  it 'can have members' do
    library = create(:library)
    member = create(:user)
    library.add_member(member)
    library.member?(member)
  end
end
