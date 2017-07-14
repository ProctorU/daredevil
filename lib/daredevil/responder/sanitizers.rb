module Daredevil
  class Responder
    module Sanitizers
      def self.status_symbol(status)
        if status.nil? || !status.is_a?(Symbol) ||
           Rack::Utils::SYMBOL_TO_STATUS_CODE[status].nil?
          raise(Daredevil::Errors::UnknownHTTPStatus, status)
        end

        Rack::Utils::SYMBOL_TO_STATUS_CODE.invert[status] if
          status.is_a?(Integer)
      end
    end
  end
end
