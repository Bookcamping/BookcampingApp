class Tagging < ActiveRecord::Base
  belongs_to :tag, counter_cache: true, touch: true
  belongs_to :reference, counter_cache: true, touch: true

  validates_presence_of :tag_id, :reference_id
end
