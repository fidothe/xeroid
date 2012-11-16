module Xeroid
  module Objects
    class Payment
      attr_reader :invoice, :account, :amount, :date, :currency_rate

      def initialize(attributes)
        @invoice = attributes[:invoice]
        @account = attributes[:account]
        @amount = attributes[:amount]
        @date = attributes[:date]
        @currency_rate = attributes[:currency_rate]
      end
    end
  end
end
