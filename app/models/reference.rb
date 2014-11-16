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

  accepts_nested_attributes_for :downloads, allow_destroy: true

  mount_uploader :cover_image, CoverUploader

  include HasTags
  after_save :save_tags

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

  def cover_filename
    "#{title.parameterize}-#{self.id}"
  end

  def downloads?
    downloads_count > 0
  end

  def urls?
    urls.size > 0
  end

  def urls
    @urls ||= [url1, url2, url3].select {|l| l.present? }
  end

  def tags?
    taggings_count > 0
  end

  def to_param
    limited = title.split[0..2].join(' ')
    "#{self.id}-#{limited.parameterize}"
  end

  protected
  def set_libre_from_license
    self.libre = self.license.libre?
  end

  def save_tags
    Tagging.where(tagged_id: self.id, tagged_type: self.class.name).destroy_all
    if self.tag_names.present?
      self.tag_names.split(',').each do |tag_name|
        add_tag(tag_name)
      end
    end
    true
  end
end
