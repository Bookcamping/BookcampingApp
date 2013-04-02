class Download < ActiveRecord::Base
  belongs_to :reference, counter_cache: true, inverse_of: :downloads

  acts_as_list scope: :reference_id
  default_scope order: 'position ASC'

  validates_presence_of :reference_id, :title
  validates_uniqueness_of :title

  mount_uploader :file, DownloadUploader
  mount_uploader :cover_image, CoverUploader

  before_validation :set_title
  before_save :set_metadata

  def to_param
    "#{self.id}-#{self.title.parameterize}"
  end

  def extension
    File.extname(self.title)
  end

  def cover_filename
    reference.title.parameterize
  end

  protected
  def set_title
    title = self.description.present? ?
      "#{self.description}".parameterize :
      reference.title.parameterize
    self.title = "#{title}.#{file.file.extension}"
  end

  def set_metadata
    if file.present? && file_changed?
      self.content_type = file.file.content_type
      self.file_size = file.file.size
    end
  end
end
