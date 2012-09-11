# License model
class License < ActiveRecord::Base
  has_many :references, dependent: :restrict

  extend FriendlyId
  friendly_id :name, use: :slugged
  has_paper_trail meta: {title: :name }

  def libre?
    self.id != 1 and self.id != 9
  end
end
