class Reference < ActiveRecord::Base
  belongs_to :library
  belongs_to :user
  belongs_to :license, counter_cache: true

  has_many :shelf_items
  has_many :shelves, through: :shelf_items

  has_many :versions, as: :item, order: 'created_at DESC'

  scope :search, lambda { |term| where('title LIKE ? OR authors LIKE ?', "%#{term}%", "%#{term}%") }

  validates :user_id, presence: true
  validates :library_id, presence: true
  validates :title, presence: true #, uniqueness: true
  validates :license_id, presence: true
  validates :ref_type, presence: true

  REF_TYPES = ['Book', 'Video', 'Audio', 'WebPage']

  attr_accessor :include_in_shelf_id

  def to_param
    limited = title.split[0..2].join(' ')
    "#{self.id}-#{limited.parameterize}"
  end

  after_create do
    if include_in_shelf_id.present?
      shelf = Shelf.find include_in_shelf_id
      shelf.add_reference self, self.user
    end
  end

  after_update do
    PaperTrail.enabled = false
    self.shelves.each do |shelf|
      shelf.touch
    end
    PaperTrail.enabled = true
  end
end
