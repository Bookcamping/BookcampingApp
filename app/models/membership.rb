class Membership < ActiveRecord::Base
  attr_accessor :user_name
  belongs_to :resource, polymorphic: true, counter_cache: true
  belongs_to :user

  validates :resource_id, presence: true
  validates :resource_type, presence: true
  validates :user_id, presence: true
  validates_uniqueness_of :user_id, scope: [:resource_id, :resource_type]

  before_validation :set_user_by_name

  protected
  def set_user_by_name
    if self.user_name.present?
      self.user = User.find_by_name(self.user_name)
    end
  end
end
