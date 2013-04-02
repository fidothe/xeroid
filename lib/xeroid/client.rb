require 'xeroid/endpoint'

module Xeroid
  class Client
    def initialize(auth_token)
      @auth_token = auth_token
    end

    def invoices
      Endpoint.new(@auth_token, 'Invoice', [:get, :post, :put], Deserialisers::Invoice, Serialisers::Invoice)
    end
  end
end
