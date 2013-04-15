require 'xeroid/objects/attributes'
require 'xeroid/objects/addresses'

module Xeroid
  module Objects
    class Contact
      include Attributes

      attribute :id, :name, :first_name, :last_name, :email_address, :addresses, :tax_number

      def addresses
        @addresses ||= EmptyAddresses.new
      end
    end
  end
end
