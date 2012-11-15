module Xeroid
  module Objects
    class Account
      attr_reader :code

      def initialize(attributes)
        @code = attributes[:code]
      end
    end
  end
end
