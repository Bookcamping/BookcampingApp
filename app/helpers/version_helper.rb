module VersionHelper
  def version_item_icon(version)
    case version.item_type
    when 'Reference'
      'icon-book'
    when 'ShelfItem'
      'icon-list-ul'
    when 'Shelf'
      'icon-bookmark-empty'
    when 'Membership'
      'icon-user'
    when 'License'
      'icon-warning-sign'
    when 'Comment'
      'icon-comment'
    when 'Subscription'
      'icon-eye-open'
    when 'Recommendation'
      'icon-heart'
    else
      version.item_type
    end
  end
end
