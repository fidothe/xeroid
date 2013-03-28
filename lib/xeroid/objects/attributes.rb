require 'bigdecimal'

module Xeroid
  module Objects
    module Attributes
      class NotABigDecimal < StandardError; end

      def self.included(base)
        base.extend(DefinitionMethods)
      end

      module DefinitionMethods
        def big_decimal(*names)
          names.each do |name|
            add_typed_attr(name, BigDecimal, NotABigDecimal)
          end
        end

        def attribute(*names)
          names.each do |name|
            attr_reader name
            untyped_attrs << name
          end
        end

        def typed_attrs
          @typed_attrs ||= {}
        end

        def untyped_attrs
          @untyped_attrs ||= []
        end

        private

        def add_typed_attr(name, type, error)
          attr_reader name
          typed_attrs[name] = [type, error]
        end
      end

      def initialize(attrs)
        attrs.each do |key, value|
          case key
          when *(self.class.typed_attrs.keys)
            type, error = self.class.typed_attrs[key]
            raise error unless value.instance_of?(type)
            instance_variable_set("@#{key}".to_sym, value)
          when *(self.class.untyped_attrs)
            instance_variable_set("@#{key}".to_sym, value)
          end
        end
      end
    end
  end
end
