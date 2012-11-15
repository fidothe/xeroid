module Xeroid
  module Objects
    class Invoice
      attr_reader :id

      def initialize(attributes)
        @id = attributes[:id]
      end
    end
  end
end
