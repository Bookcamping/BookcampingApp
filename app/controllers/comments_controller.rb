# encoding: utf-8
class CommentsController < ApplicationController
  expose(:comments)
  expose(:comment)

  def index
  end

  def show
    if comment.resource_type == 'Post'
      redirect_to root_path, alert: 'Era un comentario al blog. Visítalo en blog.bookcamping.cc'
    else
    redirect_to comment.resource
    end
  end

end
