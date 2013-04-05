require 'nokogiri'
require 'date'
require 'time'

module Xeroid
  module Deserialisers
    module Extractors
      def self.included(base)
        base.extend(DSL)
        base.extend(DeserialiseMethods)
      end

      module DSL
        attr_reader :string_mappings

        def object_class(klass = nil)
          return @object_class if klass.nil?
          @object_class = klass
        end

        def as_string(mappings)
          @string_mappings = mappings
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

          object_class.new(attributes)
        end

        def extract_strings(x, attributes)
          string_mappings.each do |attr, xpath|
            string = x.extract_string(xpath)
            attributes[attr] = string unless string.nil?
          end
        end
      end

      class Extractor
        def initialize(document)
          @document = document
        end

        def extract_string(xpath)
          nodes = @document.xpath(xpath)
          return nil if nodes.empty?
          nodes.text
        end
      end
    end
  end
end
