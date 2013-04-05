require 'nokogiri'
require 'date'
require 'time'
require 'bigdecimal'

module Xeroid
  module Deserialisers
    module Extractors
      def self.included(base)
        base.extend(DSL)
        base.extend(DeserialiseMethods)
      end

      module DSL
        def object_class(klass = nil)
          return @object_class if klass.nil?
          @object_class = klass
        end

        def as_string(mappings)
          @string_mappings = mappings
        end

        def as_currency(mappings)
          @currency_mappings = mappings
        end
      end

      module DeserialiseMethods
        def deserialise_one(xml)
          doc = Nokogiri::XML(xml)
          extractor = Extractor.new(doc)
          deserialise(extractor)
        end

        private

        def deserialise(x)
          attributes = {}
          # core attributes
          extract_strings(x, attributes)
          extract_currency(x, attributes)

          object_class.new(attributes)
        end

        def extract_strings(x, attributes)
          x.extract_from_mapping(@string_mappings, :string, attributes)
        end

        def extract_currency(x, attributes)
          x.extract_from_mapping(@currency_mappings, :currency, attributes)
        end
      end

      class Extractor
        def initialize(document)
          @document = document
        end

        def extract_from_mapping(mapping, type, attributes)
          return if mapping.nil?
          mapping.each do |attr, xpath|
            value = send("extract_#{type}", xpath)
            attributes[attr] = value unless value.nil?
          end
        end

        def extract_string(xpath)
          nodes = @document.xpath(xpath)
          return nil if nodes.empty?
          nodes.text
        end

        def extract_currency(xpath)
          string = extract_string(xpath)
          return nil if string.nil?
          BigDecimal.new(string)
        end
      end
    end
  end
end
