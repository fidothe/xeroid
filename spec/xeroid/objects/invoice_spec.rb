require 'spec_helper'

require 'xeroid/objects'

module Xeroid::Objects
  describe Invoice do
    let(:invoice) { Invoice.new(attrs) }
    describe "the bare minimum - an ID-only invoice" do
      let(:attrs) { {id: "abcde-12345-abcde-12345"} }

      it "can return its code" do
        invoice.id.should == "abcde-12345-abcde-12345"
      end
    end

    describe "the minimum required for a new draft payable invoice" do
      let(:contact) { stub('Contact') }
      let(:line_item) { stub('LineItem') }
      let(:attrs) { {type: Invoice::Type::ACCPAY, contact: contact, line_items: [line_item]} }

      it "has no id" do
        invoice.id.should be_nil
      end

      it "can return its type" do
        invoice.type.should == Invoice::Type::ACCPAY
      end

      it "can return its contact" do
        invoice.contact.should == contact
      end

      it "can return its line items" do
        invoice.line_items.should == [line_item]
      end

      it "has a status of Invoice::Status::DRAFT" do
        invoice.status.should == Invoice::Status::DRAFT
      end
    end

    describe "the minimum recommended for a new invoice" do
      let(:contact) { stub('Contact') }
      let(:line_item) { stub('LineItem') }
      let(:date) { Date.new(2013, 3, 27) }
      let(:due_date) { Date.new(2013, 4, 27) }

      let(:attrs) { {type: Invoice::Type::ACCPAY, contact: contact, line_items: [line_item], date: date, due_date: due_date} }

      it "can return its date" do
        invoice.date.should == date
      end

      it "can return its due date" do
        invoice.due_date.should == due_date
      end

      it "has a line_amount_types of Invoice::LineAmounts::EXCLUSIVE" do
        invoice.line_amount_types.should == Invoice::LineAmounts::EXCLUSIVE
      end
    end

    describe "invoice type" do
      it "can have its type set to ACCPAY" do
        invoice = Invoice.new(type: Invoice::Type::ACCPAY)
        invoice.type.should == Invoice::Type::ACCPAY
      end

      it "can have its type set to ACCREC" do
        invoice = Invoice.new(type: Invoice::Type::ACCREC)
        invoice.type.should == Invoice::Type::ACCREC
      end

      it "cannot have its type set to anything else" do
        expect { Invoice.new(type: "rubbish") }.to raise_error(Invoice::Type::Invalid)
      end
    end

    describe "status" do
      it "can have its status set to DRAFT" do
        invoice = Invoice.new(status: Invoice::Status::DRAFT)
        invoice.status.should == Invoice::Status::DRAFT
      end

      it "can have its status set to SUBMITTED" do
        invoice = Invoice.new(status: Invoice::Status::SUBMITTED)
        invoice.status.should == Invoice::Status::SUBMITTED
      end

      it "can have its status set to AUTHORISED" do
        invoice = Invoice.new(status: Invoice::Status::AUTHORISED)
        invoice.status.should == Invoice::Status::AUTHORISED
      end

      it "can have its status set to VOIDED" do
        invoice = Invoice.new(status: Invoice::Status::VOIDED)
        invoice.status.should == Invoice::Status::VOIDED
      end

      it "can have its status set to DELETED" do
        invoice = Invoice.new(status: Invoice::Status::DELETED)
        invoice.status.should == Invoice::Status::DELETED
      end

      it "can have its status set to PAID" do
        invoice = Invoice.new(status: Invoice::Status::PAID)
        invoice.status.should == Invoice::Status::PAID
      end

      it "cannot have its status set to anything else" do
        expect { Invoice.new(status: "Absurd") }.to raise_error(Invoice::Status::Invalid)
      end
    end

    describe "currency values" do
      let(:a_tenner) { BigDecimal.new("10.00") }

      [:sub_total, :total_tax, :total, :amount_due, :amount_paid, :amount_credited].each do |attr|
        it "can have #{attr} set to a decimal" do
          invoice = Invoice.new(attr => a_tenner)
          invoice.send(attr).should == a_tenner
        end

        it "cannot have its #{attr} set to a string" do
          expect { Invoice.new(attr => "10") }.to raise_error(Xeroid::Objects::Attributes::NotABigDecimal)
        end
      end
    end

    describe "the updated-at timestamp" do
      let(:timestamp) { Time.utc(2013, 4, 5, 12, 4, 54) }

      it "can have its timestamp set to a Time" do
        invoice = Invoice.new(updated_date_utc: timestamp)
        invoice.updated_date_utc.should == timestamp
      end

      it "cannot have its timestamp set to anything else" do
        expect { Invoice.new(updated_date_utc: "Midday") }.to raise_error(Xeroid::Objects::Attributes::NotATime)
      end
    end

    describe "the currency code" do
      it "can have its currency code set" do
        invoice = Invoice.new(currency_code: "EUR")
        invoice.currency_code.should == "EUR"
      end
    end

    describe "the invoice number" do
      it "can have its invoice number set" do
        invoice = Invoice.new(invoice_number: "AB1234")
        invoice.invoice_number.should == "AB1234"
      end
    end

    describe "creating invoice objects" do
      it "offers a method for creating an invoice given args and a block creating Line Items" do
        line_item = stub('LineItem')
        invoice = Invoice.new_with_line_items({}) do |line_items|
          line_items << line_item
        end

        invoice.line_items.should == [line_item]
      end
    end

    context "ACCREC-only attributes" do
      it "can have its reference set" do
        invoice = Invoice.new(reference: "QWERTYUIOP")
        invoice.reference.should == "QWERTYUIOP"
      end
    end
  end
end
