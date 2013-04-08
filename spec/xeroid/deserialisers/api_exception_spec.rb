require 'spec_helper'

require 'xeroid/deserialisers/api_exception'

module Xeroid::Deserialisers
  describe APIException do
    it "should report '/' as its content node xpath" do
      APIException.content_node_xpath.should == '/'
    end

    context "with <APIExpception> as the root (e.g. from an HTTP 400)" do
      let(:nodeset) { Nokogiri::XML(read_xml_fixture('api_exception')) }

      it "correctly extracts the errors" do
        result = APIException.deserialise_from_node(nodeset)
        result.errors.should == ["Email address must be valid."]
      end
    end
  end
end
