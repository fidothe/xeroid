require 'spec_helper'

require 'xeroid/deserialisers/invoice'
require 'bigdecimal'

module Xeroid::Deserialisers
  describe Invoice do
    it "reports the xpath to the Invoice root node" do
      Invoice.content_node_xpath.should == '/Response/Invoices/Invoice'
    end

    describe "a simple invoice" do
      let(:result) { Invoice.deserialise_one(read_xml_fixture('simple_invoice')) }

      it "correctly extracts the id" do
        result.id.should == "243216c5-369e-4056-ac67-05388f86dc81"
      end

      it "correctly extracts the invoice type" do
        result.type.should == Xeroid::Objects::Invoice::Type::ACCREC
      end

      it "correctly extracts the date" do
        result.date.should == Date.new(2009, 5, 27)
      end

      it "correctly extracts the due date" do
        result.due_date.should == Date.new(2009, 06, 06)
      end

      it "correctly extracts the status" do
        result.status.should == Xeroid::Objects::Invoice::Status::AUTHORISED
      end

      it "correctly extracts the line amount types" do
        result.line_amount_types.should == Xeroid::Objects::Invoice::LineAmounts::EXCLUSIVE
      end

      it "correctly extracts the sub total" do
        result.sub_total.should == BigDecimal.new("1800.00")
      end

      it "correctly extracts the total tax" do
        result.total_tax.should == BigDecimal.new("225.00")
      end

      it "correctly extracts the total" do
        result.total.should == BigDecimal.new("2025.00")
      end

      it "correctly extracts the updated-at timestamp" do
        result.updated_date_utc.should == Time.xmlschema('2009-08-15T00:18:43.457Z')
      end

      it "correctly extracts the currency code" do
        result.currency_code.should == 'NZD'
      end

      it "correctly extracts the invoice number" do
        result.invoice_number.should == 'OIT00546'
      end

      it "correctly extracts the amount due" do
        result.amount_due.should == BigDecimal.new("1025.00")
      end

      it "correctly extracts the amount paid" do
        result.amount_paid.should == BigDecimal.new("1000.00")
      end

      it "correctly extracts the amount credited" do
        result.amount_credited.should == BigDecimal.new("0.0")
      end
    end
  end
end
