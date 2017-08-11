require 'daredevil/configuration'
require 'daredevil/responder/actions'
require 'daredevil/responder/responses'
require 'daredevil/responder/sanitizers'

module Daredevil
  class Responder
    include Actions
    include Responses
    include Sanitizers

    attr_accessor :errors
    attr_accessor :status
    attr_reader :resource
    attr_reader :options
    attr_reader :params
    attr_reader :controller
    attr_reader :namespace

    def initialize(resource, options = {})
      @resource = resource
      @options = options
      self.status = @options[:status]
      @params = @options[:params]
      @controller = @options[:controller]
      @namespace = @options[:namespace]
    end

    def respond!
      render_response
    end

    def render_response
      return send("respond_to_#{action}_action") if action.in?(ACTIONS)
      raise(Daredevil::Errors::UnknownAction, action)
    end

    def render_error
      controller.render(error_render_options)
    end

    private

    def status=(status)
      @status = Sanitizers.status_symbol(status)
    end

    def status_code
      Rack::Utils::SYMBOL_TO_STATUS_CODE[status]
    end

    def action
      params[:action]
    end

    def render_error
      controller.render(error_render_options)
    end

    def error_render_options
      render_options.merge(
        json: {
          status: status_code,
          message: general_error_message
        }.tap do |added_errors|
          added_errors_obj(added_errors)
          added_resource(added_errors)
          added_message(added_errors)
        end
      )
    end

    def render_options
      {
        status: status,
        content_type: 'application/vnd.api+json'
      }
    end

    def error_response
      return if errors
      resource.errors.inject([]) do |new_errors, (attribute, message)|
        new_errors << {
          resource: resource_name.titleize,
          field: attribute,
          reason: message,
          detail: resource.errors.full_message(attribute, message)
        }
      end
    end

    def resource_name
      return resource.object.class.name if resource.respond_to?(:decorated?) &&
        resource.decorated?
      resource.class.name
    end

    def general_error_message
      I18n.t('daredevil.errors.conflict.reason')
    end

    def added_errors_obj(error_obj)
      error_obj[:errors] = error_response unless errors
    end

    def added_resource(error_obj)
      return unless errors
      error_obj[:resource] = resource_model_or_param
      error_obj[:detail] = errors[:detail]
    end

    def resource_model_or_param
      return resource.model if resource.try(:model).present?
      resource_param
    end

    def resource_param
      resource.param if
        resource.class.name.eql?('ActionController::ParameterMissing')
    end

    def added_message(error_obj)
      error_obj[:message] = errors[:reason] if errors
    end
  end
end
