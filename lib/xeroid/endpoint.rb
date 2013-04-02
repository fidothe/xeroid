module Xeroid
  class Endpoint
    def initialize(auth_token, path, methods, deserialiser)
      @auth_token = auth_token
      @path = path
      @allowed_methods = methods
      @deserialiser = deserialiser
    end

    def all
      raise HTTPMethodNotAllowed if !@allowed_methods.include?(:get)
      @deserialiser.process_many(fetch_response)
    end

    def fetch_response(method)
      @auth_token.send(method, "/api.xro/2.0/#{@path}")
    end
  end

  class HTTPMethodNotAllowed < StandardError; end
end
