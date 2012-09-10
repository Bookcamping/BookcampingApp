class PermittedParams < Struct.new(:params, :user)
  def library
    params.require(:library).permit(*library_attributes)
  end

  def library_attributes
    [:name, :slug, :description]
  end
end
