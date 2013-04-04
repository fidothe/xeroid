module Xeroid
  class APIResponse
    OKAY = 0

    def self.handle_one_response(deserialiser, http_response)
      object = deserialiser.deserialise_one(http_response.body)
      new(object, status: OKAY)
    end
  end
end
