module Xeroid
  module Objects
    module InitializeAttributes
      def initialize_attributes(attributes, simple, restrictions)
        restricted_attrs = restrictions.keys
        attributes.each do |key, value|
          if restricted_attrs.include?(key)
            attr = restrictions[key]
            raise attr::Invalid unless attr::VALID.include?(value)
            instance_variable_set("@#{key}".to_sym, value)
          end
          instance_variable_set("@#{key}".to_sym, value) if simple.include?(key)
        end
      end
    end
  end
end
