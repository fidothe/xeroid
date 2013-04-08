require 'nokogiri'
require 'xeroid/objects/validation_errors'

module Xeroid
  module Deserialisers
    class APIException
      def self.content_node_xpath
        '/'
      end

      def self.deserialise_from_node(nodeset)
        errors = nodeset.css('ValidationError Message').collect { |e| e.text }

        Objects::ValidationErrors.new(errors)
      end
    end
  end
end
