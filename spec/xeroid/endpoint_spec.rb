require 'spec_helper'

require 'xeroid/endpoint'

module Xeroid
  describe Endpoint do
    let(:stub_token) { stub('Xeroid::Auth::Private') }
    let(:stub_response) { stub('Response') }
    let(:stub_deserialiser) { stub('Xeroid::Deserialisers::Thing') }
    let(:stub_result) { stub('Xeroid::Objects::Thing') }
    let(:api_path_prefix) { '/api.xro/2.0' }

    describe "making the HTTP request with the Auth'd access token" do
      let(:endpoint) { Endpoint.new(stub_token, 'Endpoint', [], stub_deserialiser) }

      it "can correctly form the URL for a fetch-many request" do
        stub_token.should_receive(:get).with("#{api_path_prefix}/Endpoint").and_return(stub_response)

        endpoint.fetch_response(:get).should == stub_response
      end

      it "can correctly form the URL for a fetch-one request" do
        stub_token.should_receive(:get).with("#{api_path_prefix}/Endpoint/the_id").and_return(stub_response)

        endpoint.fetch_response(:get, 'the_id').should == stub_response
      end
    end

    describe "making GET requests" do
      it "cannot make the request if GET is not an allowed HTTP method" do
        endpoint = Endpoint.new(stub_token, 'Endpoint', [], stub_deserialiser)
        expect { endpoint.all }.to raise_error(HTTPMethodNotAllowed)
      end

      it "deserialises the response correctly for a fetch-many call" do
        endpoint = Endpoint.new(stub_token, 'Endpoint', [:get], stub_deserialiser)
        endpoint.stub(:fetch_response).and_return(stub_response)

        stub_deserialiser.should_receive(:process_many).with(stub_response).and_return([stub_result])

        endpoint.all.should == [stub_result]
      end
    end
  end
end
