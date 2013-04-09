require 'spec_helper'

require 'xeroid/deserialisers/payment'
require 'bigdecimal'

module Xeroid::Deserialisers
  describe Payment do
    it "reports its object class is Xeroid::Objects::LineItem" do
      Payment.object_class.should be(Xeroid::Objects::Payment)
    end

    describe "processing the basic attributes" do
      let(:doc) { Nokogiri::XML(read_xml_fixture('single_payment')) }
      let(:node) { doc.xpath('/Response/Payments/Payment').first }
      let(:payment) { Payment.deserialise_from_node(node) }

      it "can extract the invoice" do
        payment.invoice.id.should == '3a669bd8-b601-4b9a-81d4-cb03f1af3059'
      end

      it "can extract the account" do
        payment.account.code.should == '090'
      end

      it "can extract the date" do
        payment.date.should == Date.new(2013, 2, 22)
      end

      it "can extract the amount" do
        payment.amount.should == BigDecimal.new("31.39")
      end

      context "Foreign currency payments" do
        it "can extract the currency rate"
      end
    end
  end
end
