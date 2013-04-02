module LibraryHelper
  def library_path?(library)
    path = request.env['REQUEST_PATH']
    library.blank? || path.present? && path[1..-1] == library.slug
  end
end
