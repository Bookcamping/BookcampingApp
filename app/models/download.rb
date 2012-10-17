class Download < ActiveRecord::Base
  belongs_to :reference, counter_cache: true
  belongs_to :user

  acts_as_list scope: :reference_id
  validates_presence_of :reference_id, :user_id, :file, :title
  validates_uniqueness_of :title, scope: :reference_id

  mount_uploader :file, DownloadUploader

  before_save :set_metadata

  def name
    File.basename(self.file.path)
  end

  protected
  def set_metadata
    if file.present? && file_changed?
      self.content_type = file.file.content_type
      self.file_size = file.file.size
    end
  end
end
