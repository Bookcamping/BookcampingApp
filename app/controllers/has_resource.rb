module HasResource
  extend ActiveSupport::Concern

  module ClassMethods
    # expose_parent [:reference, shelf], default: Site
    def expose_parent(parents, options = {})
      options.reverse_merge! as: :parent, parents: [],
        default: nil, raise_if_nil: true

      expose(options[:as]) do
        parent_name = parents.find {|n| params["#{n}_id"].present? }
        if parent_name.present?
          klass = parent_name.to_s.camelcase.constantize
          klass.find(params["#{parent_name}_id"])
        else
          if options[:default].present?
            options[:default]
          elsif options[:raise_if_nil]
            throw ActiveRecord::RecordNotFound.new("Parent not found #{options[:parents].inspect}")
          else
            nil
          end
        end
      end
    end
  end

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
    flash[:notice] = t("#{name}s.#{action}d",
                       default: t("resource.#{action}d"))
  end

  private
  def modify_resource(action, model, name, &block)
    authorize! action, model
    if action == :destroy
      flash_for(:destroye, name) if model.destroy
    else
      model.attributes = permitted_params.send(name)
      flash_for(action, name) if model.save
    end
    url = block_given? ? yield : url_for(model)
    respond_with model, location: url
  end

end
