module Activity
  def activity?(version)
    !(version.event == 'update' || version.item_type == 'ShelfItem')
  end

  def activity(versions, options = {})
    Scope.new(versions.where(activity: true), options)
  end

  extend self
end
