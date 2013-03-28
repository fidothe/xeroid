require 'xeroid/objects/initialize_attributes'

module Xeroid
  module Objects
    class Contact
      include InitializeAttributes

      SIMPLE_ATTRS = [:name, :first_name, :last_name]

      attr_reader *SIMPLE_ATTRS

      def initialize(attributes)
        initialize_attributes(attributes, SIMPLE_ATTRS, {})
      end
    end
  end
end
