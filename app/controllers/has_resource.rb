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
    modify_resource(:create, model, name, &block)
  end

  def update!(model, name, &block)
    modify_resource(:update, model, name, &block)
  end

  def destroy!(model, name, &block)
    modify_resource(:destroy, model, name, &block)
  end

  def flash_for(action, name)
    flash[:notice] = t("#{name}s.#{action}d", default: "resource.#{action}d")
  end

  private
  def modify_resource(action, model, name, &block)
    authorize! action, model
    if action == :destroy
      flash_for(:destroy, name) if model.destroy
    else
      model.attributes = permitted_params.send(name)
      flash_for(action, name) if model.save
    end
    url = block_given? ? yield : url_for(model)
    respond_with model, location: url
  end

end
