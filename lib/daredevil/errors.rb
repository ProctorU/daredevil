require_relative 'utils/rack_helper'

module Daredevil
  module Errors
    class UnknownHTTPStatus < StandardError
      include Utils::RackHelper

      attr_reader :status

      def initialize(status)
        @status = status
        super(message)
      end

      def message
        "Unknown HTTP status code '#{status}'.\n"\
        "Available status codes and symbols are: #{statuses}"
      end

      private

      def statuses
        (status_symbols + status_codes).join(', ')
      end
    end

    class UnknownAction < StandardError
      attr_reader :action

      def initialize(action)
        @action = action
        super(message)
      end

      def message
        "Unknown controller action '#{action}'.\n"\
        "Accepted actions are #{Daredevil::Responder::ACTIONS.join(', ')}"
      end
    end
  end
end
