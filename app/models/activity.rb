module Activity
  def activity?(version)
    version.event == 'create' && 
      version.item_type != 'ShelfItem' &&
      version.item_type != 'Membership'
  end

  def activity(versions, options = {})
    Scope.new(versions.where(activity: true), options)
  end

  def reference(version)
    case version.item_type
    when 'Reference'
      version.item
    when 'Recommendation'
      version.item.reference
    else
      nil
    end
  end

  extend self
end
