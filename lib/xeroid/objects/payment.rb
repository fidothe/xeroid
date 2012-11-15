module Xeroid
  module Objects
    class Payment
      attr_reader :invoice, :account, :amount, :date

      def initialize(attributes)
        @invoice = attributes[:invoice]
        @account = attributes[:account]
        @amount = attributes[:amount]
        @date = attributes[:date]
      end
    end
  end
end
