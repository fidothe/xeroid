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
  end
end
