class Activity
  attr_accessor :versions

  def initialize(model, options = {})
    options.reverse_merge! page: 1, per_page: 30

    versions = if model == :site
                 Version.scoped
               elsif model.class == User
                Version.where(whodunnit: model.id.to_s)
               elsif model.class == Shelf
                 ids = model.references
                 puts "SQL: #{ids.to_sql}"
                 ids = ids.pluck '"references"."id"'
                 Version.where(item_type: 'Reference').
                   where(item_id: ids)
               end
    @versions = versions.order('id DESC').limit(options[:per_page])
  end
end
