class Activity < ActiveRecord::Base
  belongs_to :user
  belongs_to :resource, polymorphic: true
  belongs_to :parent, polymorphic: true
  default_scope order: 'id DESC'

  validates_presence_of :user_id, :resource_id, :resource_type
  validates_presence_of :parent_type, :parent_id
  validates_presence_of :action, :title
end
