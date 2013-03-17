module ShelfHelper
  def shelf_partial(shelf)
    view = shelf.visualization? ? shelf.visualization : 'list'
    "shelves/show/#{view}"
  end
  def param_link(key, name, value, options = {})
    css = ''
    if params[key] == value.to_s || (params[key].blank? && options[:default])
      css = 'current'
    end
    link_to name, url_for(key => value), class: "param_key #{css}"
  end
end
