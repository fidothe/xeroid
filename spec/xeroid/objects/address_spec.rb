require 'spec_helper'

require 'xeroid/objects/address'

module Xeroid::Objects
  describe Address do
    let(:address) { Address.new(type: Address::Type::POBOX, address_lines: ["Oranienstrasse 22"], city: "Berlin", region: "Berlin too", postal_code: "10999", country: "Germany", attention_to: "Hausmeister") }

    it "can return its address type" do
      address.type.should == Address::Type::POBOX
    end

    it "can return its address lines" do
      address.address_lines.should == ['Oranienstrasse 22']
    end

    it "can return its city" do
      address.city.should == "Berlin"
    end

    it "can return its region" do
      address.region.should == "Berlin too"
    end

    it "can return its postal code" do
      address.postal_code.should == "10999"
    end

    it "can return its country" do
      address.country.should == "Germany"
    end

    it "can return the person for whose attention things should be" do
      address.attention_to.should == "Hausmeister"
    end

    context "constrained address type" do
      it "can have its type set to STREET too" do
        Address.new(type: Address::Type::STREET).type.should == Address::Type::STREET
      end

      it "cannot have its type set to something else" do
        expect { Address.new(type: "Mailbox") }.to raise_error(Address::Type::Invalid)
      end
    end
  end
end
