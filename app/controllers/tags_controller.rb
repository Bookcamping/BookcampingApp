class TagsController < ApplicationController
  def index
    @tags = Tag.all
    index!(Tag)
  end

  def show
    @tag = Tag.find params[:id]
    show!(@tag)
  end
end
