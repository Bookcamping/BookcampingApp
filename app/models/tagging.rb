class Tagging < ActiveRecord::Base
  belongs_to :tag, counter_cache: true, touch: true
  belongs_to :tagged, counter_cache: true, touch: true, polymorphic: true

  validates_presence_of :tag_id, :tagged_id, :tagged_type

end
