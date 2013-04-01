require 'spec_helper'

require 'xeroid/endpoint'

module Xeroid
  describe Endpoint do
    let(:stub_auth) { stub('Xeroid::Auth') }
    let(:stub_response) { stub('Response') }

    it "can make a GET request to an endpoint" do
      endpoint = Endpoint.new(stub_auth, 'Endpoint')
      stub_auth.should_receive(:get).with('/api.xro/2.0/Endpoint').and_return(stub_response)

      endpoint.all().should == stub_response
    end
  end
end
