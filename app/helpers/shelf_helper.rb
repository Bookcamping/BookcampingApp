module ShelfHelper
  def shelf_partial(shelf, param)
    view = ['list', 'icons'].include?(param) ? param : nil
    view ||= shelf.visualization? ? shelf.visualization : 'list'
    "shelves/as_#{view}"
  end
  def param_link(key, name, value, options = {})
    css = ''
    if params[key] == value.to_s || (params[key].blank? && options[:default])
      css = 'current'
    end
    link_to name, url_for(key => value), class: "param_key #{css}"
  end
end
