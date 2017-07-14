module Daredevil
  class Responder
    module Responses
      def not_found
        self.errors = {
          reason: I18n.t('json_api.errors.not_found.reason')
        }
        render_error
      end

      def parameter_missing
        self.errors = {
          reason: I18n.t('json_api.errors.parameter_missing.reason'),
          detail: I18n.t(
            'json_api.errors.parameter_missing.detail',
            parameter: resource.param
          )
        }
        render_error
      end

      def unauthorized
        self.errors = {
          reason: I18n.t('json_api.errors.forbidden.reason')
        }
        render_error
      end
    end
  end
end
