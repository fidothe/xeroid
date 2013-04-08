require 'xeroid/objects/attributes'
require 'xeroid/objects/address'

module Xeroid
  module Objects
    class EmptyAddresses
      def empty?
        true
      end
    end

    class Addresses
      include Attributes

      attribute :pobox, :street

      def pobox
        @pobox || EmptyAddress.new
      end

      def street
        @street || EmptyAddress.new
      end

      def empty?
        @pobox.nil? && @street.nil?
      end
    end
  end
end
