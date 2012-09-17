class CommentsController < ApplicationController
  expose(:comments)
  expose(:comment)

  def show
    redirect_to comment.resource
  end

end
