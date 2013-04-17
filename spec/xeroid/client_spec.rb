require 'spec_helper'
require 'xeroid/client'

module Xeroid
  module Serialisers
    class Invoice; end
  end

  module Deserialisers
    class Invoice; end
  end

  describe Client do
    let(:endpoint) { stub('Endpoint')  }
    let(:stub_auth) { stub('Auth') }

    it "can correctly create an Endpoint for dealing with the /Invoice endpoint" do
      Endpoint.should_receive(:new)
        .with(stub_auth, 'Invoice', [:get, :post, :put], Deserialisers::Invoice, Serialisers::Invoice)
        .and_return(endpoint)

      client = Client.new(stub_auth)
      client.invoices.should == endpoint
    end

    it "can correctly create an Endpoint for dealing with the /Payments endpoint" do
      Endpoint.should_receive(:new)
        .with(stub_auth, 'Payments', [:get, :put], Deserialisers::Payment, Serialisers::Payment)
        .and_return(endpoint)

      client = Client.new(stub_auth)
      client.payments.should == endpoint
    end

    it "can correctly create an Endpoint for dealing with the /Contacts endpoint" do
      Endpoint.should_receive(:new)
        .with(stub_auth, 'Contacts', [:get, :post, :put], Deserialisers::Contact, Serialisers::Contact)
        .and_return(endpoint)

      client = Client.new(stub_auth)
      client.contacts.should == endpoint
    end
  end
end
