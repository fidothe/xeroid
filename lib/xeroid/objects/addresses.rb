require 'xeroid/objects/attributes'
require 'xeroid/objects/address'

module Xeroid
  module Objects
    class EmptyAddresses
    end

    class Addresses
      include Attributes

      attribute :pobox, :street

      def pobox
        @pobox || EmptyAddress
      end

      def street
        @street || EmptyAddress
      end
    end
  end
end
