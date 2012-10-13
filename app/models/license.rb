# License model
class License < ActiveRecord::Base
  has_many :references, dependent: :restrict

  extend FriendlyId
  friendly_id :name, use: :slugged
  has_paper_trail meta: {title: :name }

  LICENSE_TYPES = ['cc', 'pd', 'copyright', 'unknown']
end
