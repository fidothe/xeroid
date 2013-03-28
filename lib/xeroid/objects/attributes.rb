require 'bigdecimal'

module Xeroid
  module Objects
    module Attributes
      class NotABigDecimal < StandardError; end

      def self.included(base)
        base.extend(DefinitionMethods)
      end

      module DefinitionMethods
        def big_decimal(name)
          add_typed_attr(name, BigDecimal, NotABigDecimal)
        end

        def typed_attrs
          @typed_attrs ||= {}
        end

        private

        def add_typed_attr(name, type, error)
          attr_reader name
          typed_attrs[name] = [type, error]
        end
      end

      def initialize(attrs)
        attrs.each do |key, value|
          if self.class.typed_attrs.keys.include?(key)
            type, error = self.class.typed_attrs[key]
            raise error unless value.instance_of?(type)
            instance_variable_set("@#{key}".to_sym, value)
          end
        end
      end
    end
  end
end
