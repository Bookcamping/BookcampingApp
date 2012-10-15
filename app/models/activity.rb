module Activity
  def activize(version)
    version.activity = false unless version.event == 'create'
    case version.item_type
    when 'Recommendation'
      version.reference_id = version.item.reference_id if version.item
    when 'Reference'
      version.reference_id = version.item_id
    when 'Membership'
      version.activity = false
    when 'Shelf'
      version.shelf_id = version.item_id
    when 'ShelfItem'
      version.activity = false
      version.shelf_id = version.item.shelf_id if version.item
    when 'Subscription'
      version.shelf_id = version.item.shelf_id if version.item
    end
    version.save(validate: false)
  end

  def activity(versions, options = {})
    Scope.new(versions.where(activity: true), options)
  end

  extend self
end
