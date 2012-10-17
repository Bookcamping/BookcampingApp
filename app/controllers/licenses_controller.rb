class LicensesController < ApplicationController
  before_filter :require_user
  expose(:licenses) { License.all }
  expose(:license)

  def index
    index!(License)
  end

  def show
    show!(license)
  end

  def edit
    edit!(license)
  end

  def update
    update!(license, :license) do
      licenses_path
    end
  end
end
