require 'xeroid/objects/initialize_attributes'

module Xeroid
  module Objects
    class Invoice
      include InitializeAttributes

      module Status
        DRAFT = :draft
        SUBMITTED = :submitted
        AUTHORISED = :authorised
        VOIDED = :voided
        DELETED = :deleted

        VALID = [DRAFT, SUBMITTED, AUTHORISED, VOIDED, DELETED]

        class Invalid < StandardError; end
      end

      # whether the invoice's line item amounts are exclusive or inclusive of sales tax
      module LineAmounts
        EXCLUSIVE = :exclusive
      end

      # the two invoice types
      module Type
        ACCPAY = :accpay
        ACCREC = :accrec

        VALID = [ACCPAY, ACCREC]

        class Invalid < StandardError; end
      end

      SIMPLE_ATTRS = [:id, :contact, :type, :line_items, :date, :due_date]
      RESTRICTIONS = {:type => Type, :status => Status}

      attr_reader *SIMPLE_ATTRS

      def initialize(attributes)
        initialize_attributes(attributes, SIMPLE_ATTRS, RESTRICTIONS)
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
