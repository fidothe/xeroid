require 'spec_helper'

require 'xeroid/deserialisers/invoice'
require 'bigdecimal'

module Xeroid::Deserialisers
  describe Invoice do
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
    # <TotalTax>225.00</TotalTax>
    # <Total>2025.00</Total>
    # <UpdatedDateUTC>2009-08-15T00:18:43.457</UpdatedDateUTC>
    # <CurrencyCode>NZD</CurrencyCode>
    # <InvoiceNumber>OIT00546</InvoiceNumber>
    # <AmountDue>1025.00</AmountDue>
    # <AmountPaid>1000.00</AmountPaid>
    # <AmountCredited>0.00</AmountCredited>

    end
  end
end
