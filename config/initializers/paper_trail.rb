
class Version < ActiveRecord::Base
  attr_accessible :title, :user_name, :library_id, :shelf_id, :extra

  belongs_to :user, foreign_key: :whodunnit, class_name: 'User'
end

module PaperTrail
  def self.without_versioning
    was_enabled = PaperTrail.enabled?
    PaperTrail.enabled = false
    begin
      yield
    ensure
      PaperTrail.enabled = was_enabled
    end
  end
end

