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
    end
  end
end
