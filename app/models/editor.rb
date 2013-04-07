class Editor < ActiveRecord::Base
  belongs_to :editable, polymorphic: true
  belongs_to :user

  def self.edit(editable, user)
    editor = editable.editors.where(user_id: user.id).first
    editor ||= Editor.create(editable: editable, user: user)
    editor.update_attribute(:count, editor.count + 1)
    editor
  end
end
