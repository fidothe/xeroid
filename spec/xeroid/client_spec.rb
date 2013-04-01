require 'spec_helper'
require 'xeroid/client'

module Xeroid
  describe Client do
    let(:endpoint) { stub('Endpoint')  }
    let(:stub_auth) { stub('Auth') }

    it "can correctly create an Endpoint for dealing with the /Invoice endpoint" do
      Endpoint.should_receive(:new)
        .with(stub_auth, [:get, :post, :put], [:id, :invoice_number], [:modified_after, :where, :order])
        .and_return(endpoint)

      client = Client.new(stub_auth)
      client.invoices.should == endpoint
    end
  end
end
