require 'xeroid/objects'
require 'nokogiri'

module Xeroid
  module Deserialisers
    class Invoice
      def self.deserialise_one(xml)
        doc = Nokogiri::XML(xml)
        new(doc).deserialise
      end

      def initialize(document)
        @document = document
      end

      def deserialise
        attributes = {}
        # core attributes
        attributes[:id] = @document.xpath('/Invoices/Invoice/InvoiceID').text
        
        Objects::Invoice.new(attributes)
      end
    end
  end
end
