class VersionObserver < ActiveRecord::Observer
  def after_create(version)
    Activity.activize(version)
  end
end
