module Xeroid
  module Objects
    class Invoice
      module Status
        DRAFT = :draft
        SUBMITTED = :submitted
        AUTHORISED = :authorised
        VOIDED = :voided
        DELETED = :deleted

        VALID = [DRAFT, SUBMITTED, AUTHORISED, VOIDED, DELETED]
      end

      module LineAmounts
        EXCLUSIVE = :exclusive
      end

      class InvalidStatus < StandardError; end

      ACCPAY = :accpay

      SIMPLE_ATTRS = [:id, :contact, :type, :line_items, :date, :due_date]

      attr_reader *SIMPLE_ATTRS

      def initialize(attributes)
        attributes.each do |key, value|
          if key == :status
            raise InvalidStatus unless Status::VALID.include?(value)
            @status = value
          end
          instance_variable_set("@#{key}".to_sym, value) if SIMPLE_ATTRS.include?(key)
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
