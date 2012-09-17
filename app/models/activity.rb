class Activity
  attr_accessor :versions

  def initialize(model, options = {})
    options.reverse_merge! page: 1, per_page: 30

    versions = if model == Site
                 Version.scoped
               elsif model.class == User
                Version.where(whodunnit: model.id.to_s)
               elsif model.class == Shelf
                 Version.where(shelf_id: model.id)
               end
    @versions = versions.where('created_at IS NOT NULL').order('created_at DESC').limit(options[:per_page])
  end
end
