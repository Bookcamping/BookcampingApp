class Link < ActiveRecord::Base
  belongs_to :reference, counter_cache: true
  belongs_to :user

  default_scope order: 'position ASC'

  acts_as_list scope: :reference_id
  validates_presence_of :reference_id, :user_id, :description, :url
  validates_uniqueness_of :description, scope: :reference_id

  before_save :set_metadata

  protected
  def set_metadata
    uri ||= url.blank? ? nil : URI.parse(url)
    self.host ||= uri.try(:host)
    self.mime_type = uri ? File.extname(uri.path) : nil
  end
end
