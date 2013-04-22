class Subscription < ActiveRecord::Base
  belongs_to :shelf, counter_cache: true
  belongs_to :user, counter_cache: true
  delegate :name, to: :shelf, prefix: true
  has_many :versions, as: :item, dependent: :delete_all

  validates_presence_of :shelf_id, :user_id
  validates_uniqueness_of :user_id, scope: :shelf_id

  has_paper_trail on: [:create], meta: {
    title: :shelf_name,
    shelf_id: :shelf_id
  }

end
end
