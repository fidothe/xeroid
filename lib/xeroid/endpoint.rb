require 'xeroid/api_response'

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
      APIResponse.handle_many_response(@deserialiser, fetch_response(:get))
    end

    def fetch(id)
      APIResponse.handle_one_response(@deserialiser, fetch_response(:get, id: id))
    end

    def post_one(object)
      serialised = @serialiser.serialise_one(object)
      response = fetch_response(:post, serialised)
      APIResponse.handle_one_response(@deserialiser, response)
    end

    def fetch_response(method, *args)
      raise HTTPMethodNotAllowed if !@allowed_methods.include?(method)
      body, opts = extract_body_and_opts(args)
      id = opts[:id]
      path = ['/api.xro/2.0', @path, id].compact.join('/')
      request_args = [method, path]
      request_args << body if body
      @auth_token.send(*request_args)
    end

    private

    def extract_body_and_opts(args)
      if args.last.kind_of? Hash
        opts = args.pop
        return args.first, opts
      end
      return args.first, {}
    end
  end

  class HTTPMethodNotAllowed < StandardError; end
end
