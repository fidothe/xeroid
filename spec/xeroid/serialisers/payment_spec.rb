require 'xsd_helper'

require 'xeroid/serialisers/payment'
require 'xeroid/objects'

module Xeroid::Serialisers
  if RUBY_PLATFORM == 'java'
    describe Payment do
      let(:account) { ::Xeroid::Objects::Account.new(code: "NWBC") }
      let(:invoice) { ::Xeroid::Objects::Invoice.new(id: "abcdef12-1234-abcd-1234-abcdef123456") }

      it "produces a valid XML document given a single, minimal, Account object" do
        payment = ::Xeroid::Objects::Payment.new(invoice: invoice, account: account, amount: BigDecimal.new("10"), date: Date.parse("2012-11-15"))
        Payment.serialise_one(payment).should validate_against("Payment.xsd")
      end

      context "payments for a foreign currency invoice" do
        it "produces a valid XML document given a single, minimal, Account object" do
          payment = ::Xeroid::Objects::Payment.new(invoice: invoice, account: account, 
                                                   amount: BigDecimal.new("10"), date: Date.parse("2012-11-15"),
                                                   currency_rate: BigDecimal.new("1.2"))
          Payment.serialise_one(payment).should validate_against("Payment.xsd")
        end
      end
    end
  end
end
