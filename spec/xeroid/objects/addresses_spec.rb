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
        addresses.pobox.should be_a(EmptyAddress)
      end

      it "returns EmptyAddress by default for street" do
        addresses.street.should be_a(EmptyAddress)
      end
    end

    context "missing one address" do
      let(:addresses) { Addresses.new(pobox: stub_pobox) }

      it "returns EmptyAddress for street" do
        addresses.street.should be_a(EmptyAddress)
      end

      it "can return the pobox address" do
        addresses.pobox.should == stub_pobox
      end
    end

    context "reporting whether it has any addresses" do
      it "reports itself empty if it is" do
        Addresses.new({}).empty?.should be_true
      end

      it "reports itself non-empty if it has a single address in" do
        Addresses.new({pobox: stub_pobox}).empty?.should be_false
      end

      it "reports itself non-empty if it has a both addresses in" do
        Addresses.new({pobox: stub_pobox, street: stub_street}).empty?.should be_false
      end
    end
  end

  describe EmptyAddresses do
    it "is always empty" do
      EmptyAddresses.new.empty?.should be_true
    end
  end
end
