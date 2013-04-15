class DownloadsController < ApplicationController
  before_filter :require_user, except: [:index, :show, :fetch]
  expose(:reference) { Reference.find params[:reference_id] }
  expose(:downloads) { reference.downloads }
  expose(:download)

  def index
    download.title = reference.title.parameterize[0..199]
    index!(Download)
  end

  def new
    download.title = reference.title.parameterize[0..199]
    new!(download)
  end

  def show
    redirect_to reference
  end

  def fetch
    download = Download.find_by_title! params[:title]
    count = download.download_count + 1
    download.update_attribute(:download_count, count)
    content_type = download.content_type
    content_type = 'application/pdf' if content_type.blank?
    send_file download.file.path, type: content_type
  end

  def edit
    edit!(download)
  end

  def create
    create!(download, :download) { edit_reference_path(reference) }
  end

  def update
    update!(download, :download) { edit_reference_path(reference) }
  end

  def destroy
    destroy!(download, :download) do
      edit_reference_path(reference) 
    end
  end
end
