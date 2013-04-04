require 'spec_helper'

require 'xeroid/endpoint'
require 'xeroid/api_response'

module Xeroid
  describe Endpoint do
    let(:stub_token) { stub('Xeroid::Auth::Private') }
    let(:stub_http_response) { stub('Net::HTTPResponse') }
    let(:stub_deserialiser) { stub('Xeroid::Deserialisers::Thing') }
    let(:stub_serialiser) { stub('Xeroid::Serialisers::Thing') }
    let(:stub_api_response) { stub('Xeroid::APIResponse') }
    let(:api_path_prefix) { '/api.xro/2.0' }

    describe "making the HTTP request with the Auth'd access token" do
      let(:endpoint) { Endpoint.new(stub_token, 'Endpoint', [:get], stub_deserialiser) }

      it "can correctly form the URL for a fetch-many request" do
        stub_token.should_receive(:get).with("#{api_path_prefix}/Endpoint").and_return(stub_http_response)

        endpoint.fetch_response(:get).should == stub_http_response
      end

      it "can correctly form the URL for a fetch-one request" do
        stub_token.should_receive(:get).with("#{api_path_prefix}/Endpoint/the_id").and_return(stub_http_response)

        endpoint.fetch_response(:get, id: 'the_id').should == stub_http_response
      end

      it "cannot make a request to an unsupported HTTP method" do
        endpoint = Endpoint.new(stub_token, 'Endpoint', [], stub_deserialiser)
        expect { endpoint.fetch_response(:get) }.to raise_error(HTTPMethodNotAllowed)
      end

      it "can correctly make a request with a body (e.g. Post)" do
        endpoint = Endpoint.new(stub_token, 'Endpoint', [:post], stub_deserialiser)
        stub_token.should_receive(:post).with("#{api_path_prefix}/Endpoint", 'body').and_return(stub_http_response)

        endpoint.fetch_response(:post, 'body').should == stub_http_response
      end
    end

    describe "making GET requests" do
      let(:endpoint) { Endpoint.new(stub_token, 'Endpoint', [:get], stub_deserialiser) }

      it "deserialises the response correctly for a fetch-many call" do
        endpoint.stub(:fetch_response).with(:get).and_return(stub_http_response)

        APIResponse.should_receive(:handle_many_response).with(stub_deserialiser, stub_http_response).and_return([stub_api_response])

        endpoint.all.should == [stub_api_response]
      end

      it "deserialises the response correctly for a fetch-one call" do
        endpoint.stub(:fetch_response).with(:get, id: 'the_id').and_return(stub_http_response)

        APIResponse.should_receive(:handle_one_response).with(stub_deserialiser, stub_http_response).and_return(stub_api_response)

        endpoint.fetch('the_id').should == stub_api_response
      end
    end

    describe "making POST requests" do
      let(:endpoint) { Endpoint.new(stub_token, 'Endpoint', [:post], stub_deserialiser, stub_serialiser)  }
      let(:object) { stub('Xeroid::Objects::Thing') }

      it "serialises an object correctly for a post-one call" do
        serialisation = "Serialised XML document"
        endpoint.stub(:fetch_response).with(:post, serialisation).and_return(stub_http_response)

        stub_serialiser.should_receive(:serialise_one).with(object).and_return(serialisation)
        APIResponse.should_receive(:handle_one_response).with(stub_deserialiser, stub_http_response).and_return(stub_api_response)

        endpoint.post_one(object).should == stub_api_response
      end
    end
  end
end
