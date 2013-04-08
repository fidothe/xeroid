require 'xsd_helper'

require 'xeroid/serialisers/invoice'
require 'xeroid/objects'

module Xeroid::Serialisers
  if RUBY_PLATFORM == 'java'
    describe Invoice do
      let(:contact) { ::Xeroid::Objects::Contact.new(name: "Test Contact") }
      let(:account) { ::Xeroid::Objects::Account.new(code: "200") }
      let(:minimal_draft_invoice) {
        Xeroid::Objects::Invoice.new_with_line_items(
          contact: contact, type: ::Xeroid::Objects::Invoice::Type::ACCPAY) { |line_items|
            line_items << ::Xeroid::Objects::LineItem.new(description: "A thing", quantity: 1, 
                                                          unit_amount: BigDecimal.new("10"), account: account)
        }
      }

      it "produces a valid XML document given a single, minimal, draft Invoice object" do
        Invoice.serialise_one(minimal_draft_invoice).should validate_against("Invoice.xsd")
      end

      it "produces a valid XML document given several minimal draft Invoice objects" do
        Invoice.serialise_many([minimal_draft_invoice, minimal_draft_invoice]).should validate_against("Invoice.xsd")
      end
    end
  end
end
