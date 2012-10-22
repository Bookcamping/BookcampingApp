require 'texticle/searchable'

class Reference < ActiveRecord::Base
  belongs_to :library
  belongs_to :user, counter_cache: true
  belongs_to :license, counter_cache: true
  has_many :shelf_items, dependent: :destroy
  has_many :shelves, through: :shelf_items
  has_many :comments, as: :resource, dependent: :delete_all
  has_many :reviews, dependent: :destroy
  has_one :repub, dependent: :destroy
  has_many :downloads, dependent: :destroy
  has_many :links, dependent: :destroy, order: 'position ASC'

  include HasTags

  validates_presence_of :user_id, :library_id, :title, :license_id, :ref_type
  validates_uniqueness_of :title

  REF_TYPES = ['Book', 'Article', 'Magazine', 'Zine',
               'WebArticle', 'Blog', 'Post', 'Site', 'WebPage',
               'Video', 'Audio', 'Person']

  attr_accessor :include_in_shelf

  extend Searchable(:title, :authors, :editor)
  def self.searchable_language; 'spanish' end
  has_paper_trail meta: { title: :title, library_id: :library_id }

  scope :libres, where(libre: true)

  after_validation :set_libre_from_license
  after_create :add_to_included_shelf

  def downloads?
    downloads_count > 0
  end

  def links?
    links_count > 0
  end

  def tags?
    tags.count > 0
  end

  def url_link
    begin
      @link ||= Link.new.tap do |link|
        link.url = url
        link.set_metadata
        link.description = link.nice_mime_type? ? 'Descargar' :
          I18n.t("references.downloads.#{ref_type}")
      end
    rescue
      nil
    end
  end

  def to_param
    limited = title.split[0..2].join(' ')
    "#{self.id}-#{limited.parameterize}"
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
end
