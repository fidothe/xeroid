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
        PAID = :paid

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

      attribute :id, :contact, :line_items, :date, :due_date, :currency_code, :invoice_number, :reference
      constrained :type => Type, :status => Status
      big_decimal :total, :sub_total, :total_tax, :amount, :amount_due, :amount_paid, :amount_credited
      timestamp :updated_date_utc

      def status
        @status ||= Status::DRAFT
      end

      def line_amount_types
        LineAmounts::EXCLUSIVE
      end

      def self.new_with_line_items(attributes)
        line_items = []
        yield(line_items) if block_given?
        new(attributes.merge(line_items: line_items))
      end
    end
  end
end
