# encoding: utf-8

class DownloadUploader < CarrierWave::Uploader::Base

  storage :file
  # storage :fog

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
