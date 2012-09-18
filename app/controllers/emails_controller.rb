class EmailsController < ApplicationController
  def activity
    @library = Library.find params[:id]
  end
end
