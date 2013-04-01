module Xeroid
  class Endpoint
    def initialize(auth_token, path)
      @auth_token = auth_token
      @path = path
      @methods = methods
    end

    def all
      @auth_token.get("/api.xro/2.0/#{@path}")
    end
  end
end
