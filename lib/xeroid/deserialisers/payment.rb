require 'xeroid/objects'
require 'xeroid/deserialisers/extractors'
require 'xeroid/deserialisers/invoice'
require 'xeroid/deserialisers/account'

module Xeroid
  module Deserialisers
    class Payment
      include Extractors

      root_node 'Payments/Payment'

      object_class Objects::Payment

      as_currency :amount => 'Amount'

      as_date     :date => 'Date'

      child       :invoice => ['Invoice', Deserialisers::Invoice],
                  :account => ['Account', Deserialisers::Account]
    end
  end
end
