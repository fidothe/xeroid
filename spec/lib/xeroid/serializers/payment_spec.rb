require 'spec_helper'

require 'xeroid/serializers/payment'
require 'xeroid/objects/account'
require 'xeroid/objects/invoice'
require 'xeroid/objects/payment'

require 'nokogiri'
require 'pathname'

module Xeroid::Serializers
  describe Account do
    def schema_dir
      Pathname.new(File.expand_path("../../../../../vendor/XeroAPI-Schemas/v2.00", __FILE__))
    end

    before(:all) do
      # @validator = Nokogiri::XML::Schema(File.open(schema_dir.join("Payment.xsd")))
    end

    it "produces a valid XML document given a single, minimal, Account object" do
      account = ::Xeroid::Objects::Account.new(code: "NWBC")
      invoice = ::Xeroid::Objects::Invoice.new(id: "abcde-12345-abcde-12345")
      payment = ::Xeroid::Objects::Payment.new(invoice: invoice, account: account, amount: BigDecimal.new("10"), date: Date.parse("2012-11-15"))
      xml = Payment.serialize(payment)
      p xml
      # @vaidator.valid?(xml).should be_true
    end
  end
end
