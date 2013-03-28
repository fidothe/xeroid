require 'spec_helper'

require 'xeroid/objects/invoice'

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
      let(:attrs) { {type: Invoice::ACCPAY, contact: contact, line_items: [line_item]} }

      it "has no id" do
        invoice.id.should be_nil
      end

      it "can return its type" do
        invoice.type.should == Invoice::ACCPAY
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

      let(:attrs) { {type: Invoice::ACCPAY, contact: contact, line_items: [line_item], date: date, due_date: due_date} }

      it "can return its date" do
        invoice.date.should == date
      end

      it "can return its due date" do
        invoice.due_date.should == due_date
      end

      it "has a line_amount_type of Invoice::LineAmounts::EXCLUSIVE" do
        invoice.line_amount_type.should == Invoice::LineAmounts::EXCLUSIVE
      end
    end

    describe "invoice type" do
      it "can have its type set to ACCPAY" do
        invoice = Invoice.new(type: Invoice::ACCPAY)
        invoice.type.should == Invoice::ACCPAY
      end

      it "can have its type set to ACCREC" do
        invoice = Invoice.new(type: Invoice::ACCREC)
        invoice.type.should == Invoice::ACCREC
      end

      it "cannot have its type set to anything else" do
        expect { Invoice.new(type: "rubbish") }.to raise_error(Invoice::InvalidType)
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

      it "cannot have its status set to anything else" do
        expect { Invoice.new(status: "Absurd") }.to raise_error(Invoice::InvalidStatus)
      end
    end
  end
end
