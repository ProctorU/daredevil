require 'active_support/configurable'

module Daredevil
  def self.configure(&block)
    yield @config ||= Daredevil::Configuration.new
  end

  # Global settings for Daredevil
  def self.config
    @config
  end

  class Configuration
    include ActiveSupport::Configurable

    config_accessor :responder_type

    configure do |config|
      config.responder_type = :jbuilder
    end
  end
end
