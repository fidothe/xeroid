require 'spec_helper'

require 'xeroid/api_response'

module Xeroid
  describe APIResponse do
    it "can handle a successful API response where the expected output is a single object" do
      response_body = "<Some><Api><XML/></Api></Some>"
      http_response = stub("Net::HTTPResponse", code: "200", body: response_body)
      deserialiser = stub("Xeroid::Deserialisers::Thing")
      object = stub("Xeroid::Objects::Thing")
      response = stub("Xeroid::APIResponse")

      deserialiser.should_receive(:deserialise_one).with(response_body).and_return(object)
      APIResponse.should_receive(:new).with(object, status: APIResponse::OKAY).and_return(response)

      APIResponse.handle_one_response(deserialiser, http_response).should == response
    end
  end
end
