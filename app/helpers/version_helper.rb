module VersionHelper
  def version_item_icon(version)
    icon = case version.item_type
    when 'Following'
      'icon-user'
    when 'Reference'
      'icon-upload'
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
      'icon-star'
    else
      version.item_type
    end
    raw("<i class='#{icon}'></i>")
  end
end
