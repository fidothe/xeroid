require 'spec_helper'

require 'xeroid/serialisers/payment'
require 'xeroid/objects/account'
require 'xeroid/objects/invoice'
require 'xeroid/objects/payment'

require 'nokogiri'
require 'pathname'

module Xeroid::Serialisers
  if RUBY_PLATFORM == 'java'
    describe Account do
      def schema_dir
        Pathname.new(File.expand_path("../../../../../vendor/XeroAPI-Schemas/v2.00", __FILE__))
      end

      before(:all) do
        @validator = Nokogiri::XML::Schema(File.open(schema_dir.join("Payment.xsd")))
      end

      let(:account) { ::Xeroid::Objects::Account.new(code: "NWBC") }
      let(:invoice) { ::Xeroid::Objects::Invoice.new(id: "abcdef12-1234-abcd-1234-abcdef123456") }

      it "produces a valid XML document given a single, minimal, Account object" do
        payment = ::Xeroid::Objects::Payment.new(invoice: invoice, account: account, amount: BigDecimal.new("10"), date: Date.parse("2012-11-15"))
        xml = Payment.serialize(payment)
        @validator.valid?(Nokogiri::XML(xml)).should be_true
      end

      context "payments for a foreign currency invoice" do
        it "produces a valid XML document given a single, minimal, Account object" do
          payment = ::Xeroid::Objects::Payment.new(invoice: invoice, account: account, 
                                                   amount: BigDecimal.new("10"), date: Date.parse("2012-11-15"),
                                                   currency_rate: BigDecimal.new("1.2"))
          xml = Payment.serialize(payment)
          @validator.valid?(Nokogiri::XML(xml)).should be_true
        end
      end
    end
  end
end
