require 'readability'
require 'open-uri'

class RepubsController < ApplicationController
  expose(:reference) { Reference.find params[:reference_id] }
  expose(:repub) { reference.repub ? reference.repub : reference.build_repub(params[:repub]) }

  expose(:content) do
    #source = open(reference.url).read
    #Readability::Document.new(source).content
    ''
  end

  def new
    repub.body = content
    respond_with repub
  end

  def show
    if reference.repub.blank?
      redirect_to [:new, reference, :repub]
    else
      respond_with repub
    end
  end

  def create
    flash_for(:create, :repub) if repub.save
    respond_with repub, location: [reference, repub]
  end
end
