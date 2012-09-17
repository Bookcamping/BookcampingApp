class Subscription < ActiveRecord::Base
  belongs_to :shelf, counter_cache: true
  belongs_to :user
  delegate :name, to: :shelf, prefix: true

  validates_presence_of :shelf_id, :user_id
  validates_uniqueness_of :user_id, scope: :shelf_id

  has_paper_trail meta: {
    title: :shelf_name
  }

end
