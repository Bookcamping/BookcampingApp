require 'test_helper'

describe Editor do
  it 'can edit shelf' do
    shelf = create(:shelf)
    user = create(:user)
    editor = Editor.edit(shelf, user)
    editor.must_be :present?
    editor.editable.must_equal shelf
    editor.user.must_equal user
  end

  it 'must return the same editor' do
    shelf = create(:shelf)
    user = create(:user)
    editor = Editor.edit(shelf, user)
    Editor.edit(shelf, user).must_equal editor
  end

  it 'records the edition count' do
    shelf = create(:shelf)
    user = create(:user)
    editor = Editor.edit(shelf, user)
    editor.editions.must_equal 1
    editor = Editor.edit(shelf, user)
    editor.editions.must_equal 2
  end
end
