module Xeroid
  module Objects
    class Invoice
      ACCPAY = "ACCPAY"

      ATTRS = [:id, :contact, :type, :line_items]

      attr_reader *ATTRS

      def initialize(attributes)
        attributes.each do |key, value|
          instance_variable_set("@#{key}".to_sym, value) if ATTRS.include?(key)
        end
      end
    end
  end
end
