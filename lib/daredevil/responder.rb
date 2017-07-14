require 'daredevil/responder/responses'

module Daredevil
  class Responder
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
  end
end
