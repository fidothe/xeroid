require 'xeroid/objects/attributes'

module Xeroid
  module Objects
    class Contact
      include Attributes

      attribute :id, :name, :first_name, :last_name, :email_address, :addresses

      class EmptyAddresses
      end

      def addresses
        @addresses ||= EmptyAddresses.new
      end
    end
  end
end
