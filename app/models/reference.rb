require 'texticle/searchable'

class Reference < ActiveRecord::Base
  belongs_to :library
  belongs_to :user
  belongs_to :license, counter_cache: true
  has_many :shelf_items, dependent: :destroy
  has_many :shelves, through: :shelf_items
  has_many :comments, as: :resource, dependent: :delete_all
  has_many :reviews, dependent: :destroy
  has_one :repub, dependent: :destroy
  include HasTags

  validates_presence_of :user_id, :library_id, :title, :license_id, :ref_type

  REF_TYPES = ['Book', 'Video', 'Audio', 'WebPage']

  attr_accessor :include_in_shelf

  extend Searchable(:title, :authors, :editor)
  has_paper_trail meta: { title: :title, library_id: :library_id }
  def self.searchable_language; 'spanish' end

  def to_param
    limited = title.split[0..2].join(' ')
    "#{self.id}-#{limited.parameterize}"
  end

  def self.searchable_language
    'spanish'
  end


  after_create do
    if include_in_shelf.present?
      shelf = Shelf.find include_in_shelf
      shelf.add_reference(self, self.user)
    end
  end
end
