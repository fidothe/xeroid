require 'xeroid/endpoint'
require 'xeroid/deserialisers'
require 'xeroid/serialisers'

module Xeroid
  class Client
    def initialize(auth_token)
      @auth_token = auth_token
    end

    def invoices
      Endpoint.new(@auth_token, 'Invoice', [:get, :post, :put], Deserialisers::Invoice, Serialisers::Invoice)
    end

    def payments
      Endpoint.new(@auth_token, 'Payments', [:get, :put], Deserialisers::Payment, Serialisers::Payment)
    end

    def contacts
      Endpoint.new(@auth_token, 'Contacts', [:get, :post, :put], Deserialisers::Contact, Serialisers::Contact)
    end

    def tax_rates
      Endpoint.new(@auth_token, 'TaxRates', [:get], Deserialisers::TaxRate)
    end
  end
end
