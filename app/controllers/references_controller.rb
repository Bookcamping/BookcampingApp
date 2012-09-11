class ReferencesController < ApplicationController
  expose(:references) { Reference.all }
  expose(:reference)

  def show
    show!(reference)
  end
end
