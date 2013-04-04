require 'spec_helper'

require 'xeroid/api_response'

module Xeroid
  describe APIResponse do
    let(:deserialiser) { stub("Xeroid::Deserialisers::Thing") }
    let(:object) { stub("Xeroid::Objects::Thing") }
    let(:response) { stub("Xeroid::APIResponse") }
    let(:response_body ) { "<Some><Api><XML/></Api></Some>" }

    context "HTTP 200 response" do
      let(:http_response) { stub("Net::HTTPResponse", code: "200", body: response_body) }

      it "can handle a successful API response where the expected output is a single object" do
        deserialiser.stub(:deserialise_one).with(response_body).and_return(object)

        APIResponse.should_receive(:new).with(object, status: APIResponse::OKAY).and_return(response)

        APIResponse.handle_one_response(deserialiser, http_response).should == response
      end

      it "can handle a successful API response to a GET where the expected output is many objects" do
        deserialiser.stub(:deserialise_many).with(response_body).and_return([object])

        APIResponse.should_receive(:new).with(object, status: APIResponse::OKAY).and_return(response)

        APIResponse.handle_many_response(deserialiser, http_response).should == [response]
      end
    end

    context "HTTP 400 response" do
      let(:http_response) { stub("Net::HTTPResponse", code: "400", body: response_body) }

      it "can handle an unsuccessful response (400 implies single object)" do
        Xeroid::Deserialisers::APIException.should_receive(:deserialise).with(response_body).and_return(object)

        APIResponse.should_receive(:new).with(object, status: APIResponse::API_EXCEPTION).and_return(response)

        APIResponse.handle_one_response(deserialiser, http_response).should == response
      end
    end
  end
end
