class Shelf < ActiveRecord::Base
  belongs_to :library
  belongs_to :user
  has_many :shelf_items, order: 'created_at ASC'
  has_many :references, through: :shelf_items
  include HasMembers

  extend FriendlyId
  friendly_id :name, use: :slugged
  has_paper_trail meta: {title: :name, library_id: :library_id}

  validates :user_id, presence: true
  validates :name, presence: true
end
