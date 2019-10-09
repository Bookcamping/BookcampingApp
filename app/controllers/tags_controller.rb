class TagsController < ApplicationController
  caches_page :index, :show

  def index
    @tags = Tag.all
    index!(Tag)
  end

  def show
    @tag = Tag.find(params[:id])
    show!(@tag)
  end
end
