class TagsController < ApplicationController
  def show
    @tag = Tag.find params[:id]
    show!(@tag)
  end
end