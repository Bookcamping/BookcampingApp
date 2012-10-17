module VersionHelper
  def version_item_icon_name(version)
    case version.item_type
    when 'Reference'
      'book'
    when 'Subscription', 'Shelf', 'ShelfItem'
      'bookmark-empty'
    else
      version.item_type
    end
  end

  def version_icon_name(version)
    case version.item_type
    when 'Following'
      'user'
    when 'Reference'
      'upload'
    when 'ShelfItem'
      'list-ul'
    when 'Shelf'
      'bookmark-empty'
    when 'Membership'
      'user'
    when 'License'
      'warning-sign'
    when 'Comment'
      'comment'
    when 'Subscription'
      'eye-open'
    when 'Recommendation'
      'star'
    else
      version.item_type
    end
  end

  def version_icon(version)
    icon = version_icon_name(version)
    raw("<i class='icon-#{icon}'></i>")
  end
end
