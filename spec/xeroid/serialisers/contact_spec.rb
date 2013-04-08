require 'xsd_helper'

require 'xeroid/serialisers/contact'
require 'xeroid/objects'

module Xeroid::Serialisers
  if RUBY_PLATFORM == 'java'
    describe Contact do
      context "with minimal data" do
        let(:minimal_contact) { 
          Xeroid::Objects::Contact.new(name: "Test Contact")
        }

        it "produces a valid XML document given a single Contact object" do
          Contact.serialise_one(minimal_contact).should validate_against("Contact.xsd")
        end

        it "produces a valid XML document given several Contact objects" do
          Contact.serialise_many([minimal_contact, minimal_contact]).should validate_against("Contact.xsd")
        end
      end

      context "with the useful basics filled out" do
        let(:useful_contact) { 
          Xeroid::Objects::Contact.new(name: "Test Contact", first_name: "Alfred", last_name: "User", email_address: "alfred@example.org")
        }

        it "produces a valid XML document given a single Contact" do
          Contact.serialise_one(useful_contact).should validate_against("Contact.xsd")
        end

        it "produces a valid XML document given several Contacts" do
          Contact.serialise_many([useful_contact, useful_contact]).should validate_against("Contact.xsd")
        end
      end

      context "with addresses" do
        let(:pobox) { Xeroid::Objects::Address.new(type: Xeroid::Objects::Address::Type::POBOX, address_lines: ["Oranienstrasse 22"], city: "Berlin", postal_code: "10999") }
        let(:street) { Xeroid::Objects::Address.new(type: Xeroid::Objects::Address::Type::STREET, address_lines: ["Oranienstrasse 20"], city: "Berlin", postal_code: "10999") }
        let(:addresses) { Xeroid::Objects::Addresses.new(street: street, pobox: pobox) }
        let(:contact) {
          Xeroid::Objects::Contact.new(name: "Test Contact", first_name: "Alfred", last_name: "User", email_address: "alfred@example.org", addresses: addresses)
        }

        it "produces a valid XML document given a single Contact" do
          Contact.serialise_one(contact).should validate_against("Contact.xsd")
        end

        it "produces a valid XML document given several Contacts" do
          Contact.serialise_many([contact, contact]).should validate_against("Contact.xsd")
        end
      end
    end
  end
end
