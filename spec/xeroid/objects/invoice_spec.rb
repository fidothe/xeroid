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
  end
end
