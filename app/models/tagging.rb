class Tagging < ActiveRecord::Base
  belongs_to :tag, counter_cache: true
  belongs_to :reference

  validates_presence_of :tag_id, :reference_id
end
