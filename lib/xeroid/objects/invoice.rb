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

      # whether the invoice's line item amounts are exclusive or inclusive of sales tax
      module LineAmounts
        EXCLUSIVE = :exclusive
      end

      class InvalidStatus < StandardError; end
      class InvalidType < StandardError; end

      # the two invoice types
      ACCPAY = :accpay
      ACCREC = :accrec

      SIMPLE_ATTRS = [:id, :contact, :type, :line_items, :date, :due_date]
      RESTRICTIONS = {:type => [[ACCPAY, ACCREC], InvalidType], :status => [Status::VALID, InvalidStatus]}
      RESTRICTED_ATTRS = RESTRICTIONS.keys

      attr_reader *SIMPLE_ATTRS

      def initialize(attributes)
        attributes.each do |key, value|
          if RESTRICTED_ATTRS.include?(key)
            valid_values, error_class = RESTRICTIONS[key]
            raise error_class unless valid_values.include?(value)
            instance_variable_set("@#{key}".to_sym, value)
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
