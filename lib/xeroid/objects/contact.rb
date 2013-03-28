require 'xeroid/objects/initialize_attributes'

module Xeroid
  module Objects
    class Contact
      include InitializeAttributes

      SIMPLE_ATTRS = [:name, :first_name, :last_name, :email_address]
      ATTRS = SIMPLE_ATTRS + [:addresses]

      attr_reader *SIMPLE_ATTRS

      def initialize(attributes)
        initialize_attributes(attributes, ATTRS, {})
      end

      class EmptyAddresses
      end

      def addresses
        @addresses ||= EmptyAddresses.new
      end
    end
  end
end
