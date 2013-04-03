require 'spec_helper'

require 'xeroid/deserialisers/invoice'

module Xeroid::Deserialisers
  describe Invoice do
    describe "a simple invoice" do
      let(:result) { Invoice.deserialise_one(read_xml_fixture('simple_invoice')) }

      it "correctly extracts the id" do
        result.id.should == "243216c5-369e-4056-ac67-05388f86dc81"
      end
    end
  end
end
