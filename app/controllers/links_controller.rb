class LinksController < ApplicationController
  before_filter :require_user, except: [:index, :show]
  expose(:reference) { Reference.find params[:reference_id] }
  expose(:links) { reference.links }
  expose(:link)

  def index
    index!(link)
  end

  def new
    new!(link)
  end

  def show
    redirect_to reference
  end

  def edit
    edit!(link)
  end

  def create
    link.user = current_user
    create!(link, :link) { reference_path(reference) }
  end

  def update
    update!(link, :link) { reference_links_path(reference) }
  end

  def destroy
    destroy!(link, :link) { reference_links_path(reference) }
  end
end
