class Download < ActiveRecord::Base
  belongs_to :reference, counter_cache: true, inverse_of: :downloads

  acts_as_list scope: :reference_id
  default_scope order: 'position ASC'

  validates_presence_of :reference_id, :title
  validates_uniqueness_of :title

  mount_uploader :file, DownloadUploader

  before_validation :set_title
  before_save :set_metadata

  def to_param
    "#{self.id}-#{self.title.parameterize}"
  end

  def extension
    File.extname(self.title)
  end

  protected
  def set_title
    self.name ||= reference.title if reference
    self.title = self.name.present? ?
      "#{self.name}".parameterize :
      reference.title.parameterize
    self.title = "#{title}.#{file.file.extension}" if file.file.present?
  end

  def set_metadata
    if file.present? && file_changed?
      self.content_type = file.file.content_type
      self.file_size = file.file.size
    end
  end
end
