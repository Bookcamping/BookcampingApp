class ReferencesController < ApplicationController
  expose(:references) { Reference.all }
  expose(:reference)

  def show
    show!(reference)
  end

  def edit
    edit!(reference)
  end

  def update
    update!(reference, :reference)
  end
end
