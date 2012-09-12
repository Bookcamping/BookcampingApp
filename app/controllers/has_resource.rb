module HasResource
  extend ActiveSupport::Concern

  protected
  def index!(model_class)
    authorize! :read, model_class
  end

  def show!(model)
    authorize! :read, model
    respond_with model
  end

  def new!(model)
    authorize! :create, model
    respond_with model
  end

  def edit!(model)
    authorize! :update, model
    respond_with model
  end

  def create!(model, name, &block)
    authorize! :create, model
    model.attributes = permitted_params.send(name)
    flash[:notice] = t("created") if model.save
    url = block_given? ? yield : model
    respond_with model, location: url
  end

  def update!(model, name, &block)
    authorize! :update, model
    model.attributes = permitted_params.send(name)
    flash[:notice] = t("updated") if model.save
    url = block_given? ? yield : model
    respond_with model, location: url
  end

end
