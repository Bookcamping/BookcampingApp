class Activity
  attr_accessor :versions

  def initialize(model, options = {})
    options.reverse_merge! page: 1, per_page: 30

    @model = model
    versions = if model == Site
                 Version.scoped
               elsif model.class == User
                Version.where(whodunnit: model.id.to_s)
               elsif model.class == Shelf
                 Version.where(shelf_id: model.id)
               end
    versions = versions.where('created_at IS NOT NULL')
    versions = versions.order('created_at DESC')
    @versions = versions.limit(options[:per_page])
  end

  def model_name
    @model.name
  end
end
