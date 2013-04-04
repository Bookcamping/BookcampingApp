require 'texticle/searchable'

class Reference < ActiveRecord::Base
  belongs_to :library
  belongs_to :user, counter_cache: true
  belongs_to :license, counter_cache: true
  belongs_to :publisher, class_name: 'Shelf'
  has_many :shelf_items, dependent: :destroy
  has_many :shelves, through: :shelf_items
  has_many :comments, as: :resource, dependent: :delete_all
  has_many :reviews, dependent: :destroy
  has_many :downloads, dependent: :destroy, inverse_of: :reference
  has_many :links, dependent: :destroy, order: 'position ASC', inverse_of: :reference

  accepts_nested_attributes_for :links, allow_destroy: true
  accepts_nested_attributes_for :downloads, allow_destroy: true

  include HasTags

  validates_presence_of :user_id, :library_id, :title, :license_id, :ref_type
  validates_uniqueness_of :title

  REF_TYPES = ['Book', 'Article', 'Magazine', 'Zine',
               'WebArticle', 'Blog', 'Post', 'Site', 'WebPage',
               'Video', 'Audio', 'Person']


  extend Searchable(:title, :authors, :editor)
  def self.searchable_language; 'spanish' end
  has_paper_trail meta: { title: :title, library_id: :library_id }


  scope :libres, where(libre: true)

  after_validation :set_libre_from_license
  after_save :update_first_link
  after_create :add_to_included_shelf
  attr_accessor :include_in_shelf

  def downloads?
    downloads_count > 0
  end

  def links?
    links_count > 0
  end

  def tags?
    taggings_count > 0
  end

  def to_param
    limited = title.split[0..2].join(' ')
    "#{self.id}-#{limited.parameterize}"
  end

  def url=(url)
    @url = url
  end

  def url
    @url || links.first.present? && links.first.url
  end

  protected
  def add_to_included_shelf
    if include_in_shelf.present?
      shelf = Shelf.find include_in_shelf
      shelf.add_reference(self, self.user)
    end
  end

  def set_libre_from_license
    self.libre = self.license.libre?
  end

  def update_first_link
    if url.present?
      if links.first.present?
        links.first.update_attribute(:url, url)
      else
        Link.url_link(url, self).try :save
      end
    end
  end
end
