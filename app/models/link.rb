class Link < ActiveRecord::Base
  belongs_to :reference, counter_cache: true
  belongs_to :user

  default_scope order: 'position ASC'

  acts_as_list scope: :reference_id
  validates_presence_of :reference_id, :user_id, :description, :url
  validates_uniqueness_of :description, scope: :reference_id

  before_save :set_metadata
  has_paper_trail meta: { 
    title: :description, reference_id: :reference_id }

  def domain
    @domain ||= host.split('.')[-2..-1].join('.')
  end

  def nice_mime_type?
    mime_type? && mime_type.in?(%w(.pdf .epub .jpg .png))
  end

  def set_metadata
    uri ||= url.blank? ? nil : URI.parse(url)
    self.host ||= uri.try(:host)
    self.mime_type = uri ? File.extname(uri.path)[0..15] : nil
  end
end
