require 'bigdecimal'

module Xeroid
  module Objects
    module Attributes
      class NotABigDecimal < StandardError; end
      class NotATime < StandardError; end
      class NotABoolean < StandardError; end

      def self.included(base)
        base.extend(DefinitionMethods)
      end

      module DefinitionMethods
        def big_decimal(*names)
          names.each do |name|
            add_typed_attr(name, BigDecimal, NotABigDecimal)
          end
        end

        def timestamp(*names)
          names.each do |name|
            add_typed_attr(name, Time, NotATime)
          end
        end

        def boolean(*names)
          names.each do |name|
            attr_reader name
            alias_method "#{name}?".to_sym, name
            boolean_attrs << name
          end
        end

        def attribute(*names)
          names.each do |name|
            attr_reader name
            untyped_attrs << name
          end
        end

        def constrained(names_and_constraints)
          attr_reader *names_and_constraints.keys
          @constrained_attrs = names_and_constraints
        end

        def typed_attrs
          @typed_attrs ||= {}
        end

        def untyped_attrs
          @untyped_attrs ||= []
        end

        def constrained_attrs
          @constrained_attrs ||= {}
        end

        def boolean_attrs
          @boolean_attrs ||= []
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
          when *(self.class.constrained_attrs.keys)
            constraint_module = self.class.constrained_attrs[key]
            raise constraint_module::Invalid unless constraint_module::VALID.include?(value)
            instance_variable_set("@#{key}".to_sym, value)
          when *(self.class.boolean_attrs)
            raise NotABoolean unless (value === true || value === false)
            instance_variable_set("@#{key}".to_sym, value)
          end
        end
      end
    end
  end
end
