require 'xeroid/objects/initialize_attributes'

module Xeroid
  module Objects
    class LineItem
      include InitializeAttributes

      SIMPLE_ATTRS = [:description, :quantity]

      attr_reader *SIMPLE_ATTRS

      def initialize(attributes)
        initialize_attributes(attributes, SIMPLE_ATTRS, {})
      end
    end
  end
end
