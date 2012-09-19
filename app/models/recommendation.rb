class Recommendation < ActiveRecord::Base
  belongs_to :user, counter_cache: true
  belongs_to :reference, counter_cache: true
  delegate :title, to: :reference, prefix: true

  validates_presence_of :user_id, :reference_id
  validates_uniqueness_of :reference_id, scope: :user_id

  has_paper_trail on: [:create], meta: {
    title: :reference_title 
  }

  after_destroy do
    self.versions.destroy_all
  end
end
