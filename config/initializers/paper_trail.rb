
class Version < ActiveRecord::Base
  attr_accessible :title, :user_name, :library_id, :shelf_id, :user_id
  belongs_to :user
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

