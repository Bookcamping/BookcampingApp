# encoding: utf-8
require 'carrierwave/processing/mime_types'

class DownloadUploader < CarrierWave::Uploader::Base
  include CarrierWave::MimeTypes

  storage :file
#  process :set_content_type

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "archivos/descargas/"
  end

  def extension_white_list
    %w(pdf epub)
  end

  def filename
    model.title if original_filename
  end
end
