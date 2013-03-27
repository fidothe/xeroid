module Xeroid
  module Objects
    class Invoice
      module Status
        DRAFT = :draft
        SUBMITTED = :submitted
      end

      module LineAmounts
        EXCLUSIVE = :exclusive
      end

      ACCPAY = :accpay

      SIMPLE_ATTRS = [:id, :contact, :type, :line_items, :date, :due_date]
      ATTRS = SIMPLE_ATTRS + [:status]

      attr_reader *SIMPLE_ATTRS

      def initialize(attributes)
        attributes.each do |key, value|
          instance_variable_set("@#{key}".to_sym, value) if ATTRS.include?(key)
        end
      end

      def status
        @status ||= Status::DRAFT
      end

      def line_amount_type
        LineAmounts::EXCLUSIVE
      end
    end
  end
end
