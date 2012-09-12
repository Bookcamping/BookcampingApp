module VersionsHelper

  def version_item_icon(version)
    case version.item_type
    when 'Reference'
      'icon-book'
    when 'ShelfItem'
      'icon-th-list'
    when 'Shelf'
      'icon-list'
    when 'Membership'
      'icon-user'
    when 'License'
      'icon-warning-sign'
    else
      version.item_type
    end
  end
end
