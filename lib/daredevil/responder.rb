require 'daredevil/responder/actions'
require 'daredevil/responder/responses'

module Daredevil
  class Responder
    include Actions
    include Responses

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
      raise(JsonApi::Errors::UnknownAction, action)
    end

    def render_error
      controller.render(error_render_options)
    end
  end
end
