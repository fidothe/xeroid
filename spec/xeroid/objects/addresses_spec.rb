require 'spec_helper'

require 'xeroid/objects/addresses'

module Xeroid::Objects
  describe Addresses do
    let(:stub_pobox) { stub('Xeroid::Objects::Address') }
    let(:stub_street) { stub('Xeroid::Objects::Address') }

    context "with all addresses" do
      let(:addresses) { Addresses.new(pobox: stub_pobox, street: stub_street) }

      it "can return the street address" do
        addresses.street.should == stub_street
      end

      it "can return the pobox address" do
        addresses.pobox.should == stub_pobox
      end
    end

    context "missing both addresses" do
      let(:addresses) { Addresses.new({})  }

      it "returns EmptyAddress by default for pobox" do
        addresses.pobox.should == EmptyAddress
      end

      it "returns EmptyAddress by default for street" do
        addresses.street.should == EmptyAddress
      end
    end

    context "missing one address" do
      let(:addresses) { Addresses.new(pobox: stub_pobox) }

      it "returns EmptyAddress for street" do
        addresses.street.should == EmptyAddress
      end

      it "can return the pobox address" do
        addresses.pobox.should == stub_pobox
      end
    end
  end
end
