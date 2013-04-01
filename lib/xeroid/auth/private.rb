require 'oauth'

module Xeroid
  module Auth
    class Private
      def self.create_client(key, secret, private_key_path)
        consumer_opts = {
          :site => 'https://api.xero.com',
          :signature_method => 'RSA-SHA1',
          :private_key_file => private_key_path
        }
        consumer = OAuth::Consumer.new(key, secret, consumer_opts)
        OAuth::AccessToken.new(consumer, key, secret)
      end
    end
  end
end
