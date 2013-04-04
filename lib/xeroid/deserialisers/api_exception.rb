require 'nokogiri'
require 'xeroid/objects/validation_errors'

module Xeroid
  module Deserialisers
    class APIException
      def self.deserialise(xml)
        doc = Nokogiri::XML(xml)
        new(doc).deserialise
      end

      def initialize(document)
        @document = document
      end

      def deserialise
        errors = @document.css('ValidationError Message').collect { |e| e.text }

        Objects::ValidationErrors.new(errors)
      end
    end
  end
end
