require 'xeroid/objects/attributes'

module Xeroid
  module Objects
    class Invoice
      include Attributes

      module Status
        DRAFT = :draft
        SUBMITTED = :submitted
        AUTHORISED = :authorised
        VOIDED = :voided
        DELETED = :deleted
        PAID = :deleted

        VALID = [DRAFT, SUBMITTED, AUTHORISED, VOIDED, DELETED, PAID]

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

      attribute :id, :contact, :line_items, :date, :due_date
      constrained :type => Type, :status => Status

      def status
        @status ||= Status::DRAFT
      end

      def line_amount_type
        LineAmounts::EXCLUSIVE
      end
    end
  end
end
