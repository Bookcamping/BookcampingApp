class Reference < ActiveRecord::Base
  belongs_to :license
  belongs_to :user
  has_many :shelf_items
  has_many :shelves, through: :shelf_items

  def to_param
    limited = title.split[0..2].join(' ')
    "#{self.id}-#{limited.parameterize}"
  end
end
