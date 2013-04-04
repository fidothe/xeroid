require 'xeroid/deserialisers/api_exception'

module Xeroid
  class APIResponse
    OKAY = 0
    API_EXCEPTION = 1

    def self.handle_one_response(deserialiser, http_response)
      case http_response.code
      when "200"
        object = deserialiser.deserialise_one(http_response.body)
        status = OKAY
      when "400"
        object = ::Xeroid::Deserialisers::APIException.deserialise(http_response.body)
        status = API_EXCEPTION
      end
      new(object, status)
    end

    def self.handle_many_response(deserialiser, http_response)
      objects = deserialiser.deserialise_many(http_response.body)
      objects.collect { |object| new(object, OKAY) }
    end

    attr_reader :object, :status

    def initialize(object, status)
      @object = object
      @status = status
    end

    def okay?
      status === OKAY
    end
  end
end
