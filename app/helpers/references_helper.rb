module ReferencesHelper
  def reference_color(shelf)
    shelf ? shelf.color : '#AAA'
  end
end
