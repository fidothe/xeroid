require 'xeroid/api_response'
require 'uri'

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

    def post_many(objects)
      serialised = @serialiser.serialise_many(objects)
      response = fetch_response(:post, serialised, many: true)
      APIResponse.handle_many_response(@deserialiser, response)
    end

    def fetch_response(method, *args)
      raise HTTPMethodNotAllowed if !@allowed_methods.include?(method)

      body, opts = extract_body_and_opts(args)
      id = opts[:id]
      query_params = {}
      query_params['SummarizeErrors'] = false if opts[:many]
      path = generate_path(@path, id, query_params)
      request_args = [method, path]
      request_args << {'xml' => body} if body
      @auth_token.send(*request_args)
    end

    private

    def generate_path(path, id, query_params)
      uri_args = {path: ['/api.xro/2.0', path, id].compact.join('/')}
      uri_args[:query] = URI.encode_www_form(query_params) unless query_params.empty?
      uri = URI::HTTP.build(uri_args)
      uri.request_uri
    end

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
