require 'xeroid/objects/attributes'

module Xeroid
  module Objects
    class Payment
      include Attributes

      attribute :invoice, :account, :date
      big_decimal :amount, :currency_rate
    end
  end
end
