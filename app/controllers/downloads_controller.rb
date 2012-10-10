class DownloadsController < ApplicationController
  expose(:reference) { Reference.find params[:reference_id] }
  expose(:downloads) { reference.downloads }
  expose(:download)

  def index
    index!(Download)
  end

  def new
    redirect_to reference_downloads_path(reference)
  end

  def show
    redirect_to reference
  end

  def create
    create!(download, :download) { reference_path(reference) }
  end

  def destroy
    destroy!(download, :download) { reference_download_path(reference) }
  end
end
