module Utils
  module RackHelper
    private

    def status_symbols
      Rack::Utils::SYMBOL_TO_STATUS_CODE.keys.map(&:to_s)
    end

    def status_codes
      Rack::Utils::SYMBOL_TO_STATUS_CODE.invert.keys.map(&:to_s)
    end
  end
end
