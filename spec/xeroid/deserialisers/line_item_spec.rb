require 'spec_helper'

require 'xeroid/deserialisers/line_item'
require 'bigdecimal'

module Xeroid::Deserialisers
  describe LineItem do
    it "reports its object class is Xeroid::Objects::LineItem" do
      LineItem.object_class.should be(Xeroid::Objects::LineItem)
    end

    describe "processing the basic attributes" do
      let(:doc) { Nokogiri::XML(read_xml_fixture('simple_invoice')) }
      let(:node) { doc.xpath('/Response/Invoices/Invoice/LineItems/LineItem').first }
      let(:line_item) { LineItem.deserialise_from_node(node) }

      it "can extract the description" do
        line_item.description.should == 'Onsite project management'
      end
    end
  end
end
