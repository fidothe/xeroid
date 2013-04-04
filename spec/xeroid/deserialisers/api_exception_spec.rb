require 'spec_helper'

require 'xeroid/deserialisers/api_exception'

module Xeroid::Deserialisers
  describe APIException do
    context "with <APIExpception> as the root (e.g. from an HTTP 400)" do
      let(:result) { APIException.deserialise(read_xml_fixture('api_exception')) }

      it "correctly extracts the errors" do
        result.errors.should == ["Email address must be valid."]
      end
    end
  end
end
