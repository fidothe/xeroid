require 'xsd_helper'

require 'xeroid/serialisers/invoice'
require 'xeroid/objects'

module Xeroid::Serialisers
  if RUBY_PLATFORM == 'java'
    describe Invoice do
      let(:contact) { ::Xeroid::Objects::Contact.new(name: "Test Contact") }
      let(:account) { ::Xeroid::Objects::Account.new(code: "200") }

      it "produces a valid XML document given a single, minimal, draft Invoice object" do
        invoice = ::Xeroid::Objects::Invoice.new_with_line_items(
          contact: contact, type: ::Xeroid::Objects::Invoice::Type::ACCPAY) { |line_items|
            line_items << ::Xeroid::Objects::LineItem.new(description: "A thing", quantity: 1, 
                                                          unit_amount: BigDecimal.new("10"), account: account)
        }

        Invoice.serialise_one(invoice).should validate_against("Invoice.xsd")
      end
    end
  end
end
