class PostsController < ApplicationController
  respond_to :html

  expose_resource :post

  caches_page :index, :show

  expose(:header) { 'blog' }

  def index; end

  def show; end
end
