require 'xeroid/objects/attributes'

module Xeroid
  module Objects
    class EmptyAddress
      def empty?
        true
      end
    end

    class Address
      include Attributes

      module Type
        POBOX = :pobox
        STREET = :street

        VALID = [POBOX, STREET]

        class Invalid < StandardError; end
      end

      attribute :address_lines, :city, :region, :postal_code, :country, :attention_to
      constrained :type => Type

      def address_lines
        @address_lines || []
      end

      def empty?
        false
      end
    end
  end
end
