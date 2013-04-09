# https://github.com/francesc/rails-translate-routes/pull/39
#
class RailsTranslateRoutes
    # Generate translation for a single route for one locale
    def translate_route route, locale
      if Rails.version >= '3.2'
        conditions = { :path_info => translate_path(route.path.spec.to_s, locale) }
        conditions[:request_method] = parse_request_methods route.verb if route.verb != //
        if route.constraints
          route.constraints.each do |k,v|
            conditions[k] = v unless k == :request_method
          end
        end
        defaults = route.defaults.merge LOCALE_PARAM_KEY => locale.dup
      else
        conditions = { :path_info => translate_path(route.path, locale) }
        conditions[:request_method] = parse_request_methods route.conditions[:request_method] if route.conditions.has_key? :request_method
        defaults = route.defaults.merge LOCALE_PARAM_KEY => locale
      end

      anchored = route.path.anchored
      requirements = route.requirements.merge LOCALE_PARAM_KEY => locale
      new_name = "#{route.name}_#{locale_suffix(locale)}" if route.name

      [route.app, conditions, requirements, defaults, new_name, anchored]
    end
end
