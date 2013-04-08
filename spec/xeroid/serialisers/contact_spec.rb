require 'xsd_helper'

require 'xeroid/serialisers/contact'
require 'xeroid/objects'

module Xeroid::Serialisers
  if RUBY_PLATFORM == 'java'
    describe Contact do
      let(:minimal_contact) { 
        Xeroid::Objects::Contact.new(name: "Test Contact")
      }

      it "produces a valid XML document given a single, minimal, draft Invoice object" do
        Contact.serialise_one(minimal_contact).should validate_against("Invoice.xsd")
      end

      it "produces a valid XML document given several minimal draft Invoice objects" do
        Contact.serialise_many([minimal_contact, minimal_contact]).should validate_against("Invoice.xsd")
      end
    end
  end
end
