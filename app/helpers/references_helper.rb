module ReferencesHelper
  def reference_color(shelf)
    shelf ? shelf.color : '#efefef'
  end
end
