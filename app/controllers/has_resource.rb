module HasResource
  extend ActiveSupport::Concern

  protected
  def index!(models)
    authorize! :index, models
    respond_with models
  end

  def show!(model)
    authorize! :show, model
    respond_with model
  end

  def edit!(model)
    authorize! :update, model
    respond_with model
  end

  def update!(model, name, &block)
    authorize! :update, model
    model.attributes = permitted_params.send(name)
    flash[:notice] = t("updated") if model.save
    url = block_given? ? yield : model
    respond_with model, location: url
  end

end
