require 'rails'
require 'daredevil/configuration'
require 'daredevil/engine'
require 'daredevil/responder'

module Daredevil
  def self.included(base)
    base.rescue_from ActiveRecord::RecordNotFound, with: :record_not_found!
    base.rescue_from ActionController::ParameterMissing, with: :parameter_missing!
    redefine_authorization(base)
  end

  def self.redefine_authorization(base)
    return unless base.instance_methods.include?(:authenticate_user_from_token!)

    base.class_eval do
      alias_method(:_authenticate_from_token!, :authenticate_user_from_token!)

      define_method :authenticate_user_from_token! do
        result = catch(:warden) { _authenticate_from_token! }

        return unless result
        respond_with_error(:unauthorized)
      end
    end
  end

  private

  def respond_with_error(error_type, resource = nil)
    case error_type
    when :unauthorized
      Responder.new(nil, controller: self, status: :forbidden).unauthorized
    when :not_found
      Responder.new(resource, controller: self, status: :not_found).not_found
    when :parameter_missing
      Responder.new(resource, controller: self, status: :unprocessable_entity).
        parameter_missing
    end
  end

  def respond_with(resource, options = {})
    options = {
      namespace: self.class.parent,
      status: :ok,
      params: params,
      controller: self
    }.merge(options)

    Responder.new(resource, options).respond!
  end

  def record_not_found!(error)
    respond_with_error(:not_found, error)
  end

  def parameter_missing!(error)
    respond_with_error(:parameter_missing, error)
  end
end
