require 'vcr_helper'

require 'xeroid/auth/private'

module Xeroid::Auth
  describe Private do
    let(:credentials) { Credentials.fetch }
    let(:key) { credentials['consumer_key'] }
    let(:secret) { credentials['consumer_secret'] }
    let(:private_key_path) { File.expand_path(credentials['private_key'], ENV['HOME']) }

    it "can successfully create a client and request details about the current organisation", :vcr do
      client = Private.create_token(key, secret, private_key_path)
      response = client.get('/api.xro/2.0/Organisation')
      response.code.should == '200'
    end
  end
end
