module Xeroid
  module Objects
    class Invoice
      module Status
        DRAFT = 1
      end

      ACCPAY = 1

      ATTRS = [:id, :contact, :type, :line_items]

      attr_reader *ATTRS

      def initialize(attributes)
        attributes.each do |key, value|
          instance_variable_set("@#{key}".to_sym, value) if ATTRS.include?(key)
        end
      end

      def status
        Status::DRAFT
      end
    end
  end
end
