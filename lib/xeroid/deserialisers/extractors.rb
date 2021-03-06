require 'nokogiri'
require 'date'
require 'time'
require 'bigdecimal'
require 'pathname'

module Xeroid
  module Deserialisers
    module Extractors
      def self.included(base)
        base.extend(DSL)
        base.extend(DeserialiseMethods)
      end

      module DSL
        def root_node(xpath)
          path = Pathname.new(xpath)
          root = Pathname.new('/Response')
          @root_node = (root + path).to_s
        end

        def content_node_xpath
          @root_node || '/'
        end

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

        def as_number(mappings)
          @number_mappings = mappings
        end

        def as_date(mappings)
          @date_mappings = mappings
        end

        def as_utc_timestamp(mappings)
          @utc_timestamp_mappings = mappings
        end

        def as_value(mappings)
          @value_mappings = mappings
        end

        def as_boolean(mappings)
          @boolean_mappings = mappings
        end

        def child(mappings)
          @child_mappings = mappings
        end

        def children(mappings)
          @children_mappings = mappings
        end
      end

      module DeserialiseMethods
        def deserialise_one(xml)
          doc = Nokogiri::XML(xml)
          deserialise_one_from_root(doc)
        end

        def deserialise_many(xml)
          doc = Nokogiri::XML(xml)
          deserialise_many_from_root(doc)
        end

        def content_root(doc)
          doc.xpath(content_node_xpath)
        end

        def deserialise_one_from_root(doc)
          deserialise_from_node(content_root(doc))
        end

        def deserialise_many_from_root(doc)
          deserialise_many_from_nodeset(content_root(doc))
        end

        def deserialise_from_node(node)
          extractor = Extractor.new(node)
          deserialise_with_extractor(extractor)
        end

        def deserialise_many_from_nodeset(nodeset)
          nodeset.collect { |node|
            deserialise_from_node(node)
          }
        end

        private

        def deserialise_with_extractor(x)
          attributes = {}
          # core attributes
          extract_strings(x, attributes)
          extract_currency(x, attributes)
          extract_numbers(x, attributes)
          extract_dates(x, attributes)
          extract_utc_timestamps(x, attributes)
          extract_values(x, attributes)
          extract_booleans(x, attributes)
          extract_child_objects(x, attributes)
          extract_children_objects(x, attributes)

          object_class.new(attributes)
        end

        def extract_strings(x, attributes)
          x.extract_from_mapping(@string_mappings, :string, attributes)
        end

        def extract_currency(x, attributes)
          x.extract_from_mapping(@currency_mappings, :currency, attributes)
        end

        def extract_numbers(x, attributes)
          x.extract_from_mapping(@number_mappings, :number, attributes)
        end

        def extract_dates(x, attributes)
          x.extract_from_mapping(@date_mappings, :date, attributes)
        end

        def extract_utc_timestamps(x, attributes)
          x.extract_from_mapping(@utc_timestamp_mappings, :utc_timestamp, attributes)
        end

        def extract_values(x, attributes)
          x.extract_from_mapping(@value_mappings, :value, attributes)
        end

        def extract_booleans(x, attributes)
          x.extract_from_mapping(@boolean_mappings, :boolean, attributes)
        end

        def extract_child_objects(x, attributes)
          x.extract_from_mapping(@child_mappings, :child, attributes)
        end

        def extract_children_objects(x, attributes)
          x.extract_from_mapping(@children_mappings, :children, attributes)
        end
      end

      class Extractor
        def initialize(document)
          @document = document
        end

        def extract_from_mapping(mapping, type, attributes)
          return if mapping.nil?
          mapping.each do |attr, args|
            value = send("extract_#{type}", *args)
            attributes[attr] = value unless value.nil?
          end
        end

        def extract_string(xpath)
          nodes = @document.xpath(xpath)
          return nil if nodes.empty?
          nodes.text
        end

        def extract_typed(xpath)
          string = extract_string(xpath)
          return nil if string.nil?
          yield(string)
        end

        def extract_currency(xpath)
          extract_typed(xpath) { |string| BigDecimal.new(string) }
        end

        def extract_number(xpath)
          extract_typed(xpath) { |string| string.to_f }
        end

        def extract_date(xpath)
          extract_typed(xpath) { |string| Date.parse(string) }
        end

        def extract_utc_timestamp(xpath)
          extract_typed(xpath) { |string| 
            string = string + 'Z' if string.index('Z').nil?
            Time.xmlschema(string)
          }
        end

        def extract_value(xpath, values)
          extract_typed(xpath) { |string| values[string] }
        end

        def extract_boolean(xpath)
          extract_typed(xpath) { |string| 
            case string
            when 'true'
              true
            when 'false'
              false
            else
              nil
            end
          }
        end

        def extract_child(xpath, deserialiser)
          nodes = @document.xpath(xpath)
          return nil if nodes.empty?
          deserialiser.deserialise_from_node(nodes)
        end

        def extract_children(xpath, deserialiser)
          nodes = @document.xpath(xpath)
          return nil if nodes.empty?
          deserialiser.deserialise_many_from_nodeset(nodes)
        end
      end
    end
  end
end
