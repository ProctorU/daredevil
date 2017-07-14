module Daredevil
  def self.configuration
    Configuration.new
  end

  class Configuration
    attr_accessor :default_responder_type

    def initialize
      @default_responder_type = :jbuilder
    end
  end
end
