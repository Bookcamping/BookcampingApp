class Tag < ActiveRecord::Base
  has_many :taggings
  has_many :references, through: :taggings

  include FriendlyId
  friendly_id :name, use: :slugged

  validates :name, presence: true, uniqueness: true

  before_validation do
    self.name = self.name.strip.downcase if self.name.present?
  end

  def self.find_tag(name)
    Tag.find_by_slug(name.strip.parameterize)
  end
end