module Xeroid
  class Endpoint
    def initialize(auth_token, path, methods, deserialiser, serialiser=nil)
      @auth_token = auth_token
      @path = path
      @allowed_methods = methods
      @deserialiser = deserialiser
      @serialiser = serialiser
    end

    def all
      @deserialiser.process_many(fetch_response(:get))
    end

    def fetch(id)
      @deserialiser.process_one(fetch_response(:get, id))
    end

    def post_one(object)
      serialised = @serialiser.process_one(object)
      response = fetch_response(:post, serialised)
      @deserialiser.process_one(response)
    end

    def fetch_response(method, id=nil)
      raise HTTPMethodNotAllowed if !@allowed_methods.include?(method)
      path = ['/api.xro/2.0', @path, id].compact.join('/')
      @auth_token.send(method, path)
    end
  end

  class HTTPMethodNotAllowed < StandardError; end
end
