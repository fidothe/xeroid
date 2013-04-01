require 'xeroid/endpoint'

module Xeroid
  class Client
    def initialize(auth_token)
      @auth_token = auth_token
    end

    def invoices
      Endpoint.new(@auth_token, [:get, :post, :put], [:id, :invoice_number], [:modified_after, :where, :order])
    end
  end
end
