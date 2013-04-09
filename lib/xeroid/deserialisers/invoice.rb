require 'xeroid/objects'
require 'xeroid/deserialisers/extractors'
require 'xeroid/deserialisers/contact'
require 'xeroid/deserialisers/line_item'

module Xeroid
  module Deserialisers
    class Invoice
      include Extractors
      
      root_node 'Invoices/Invoice'

      TYPES = {'ACCREC' => Xeroid::Objects::Invoice::Type::ACCREC,
               'ACCPAY' => Xeroid::Objects::Invoice::Type::ACCPAY}
      STATUSES = {
        'DRAFT' => Xeroid::Objects::Invoice::Status::DRAFT,
        'SUBMITTED' => Xeroid::Objects::Invoice::Status::SUBMITTED,
        'AUTHORISED' => Xeroid::Objects::Invoice::Status::AUTHORISED,
        'VOIDED' => Xeroid::Objects::Invoice::Status::VOIDED,
        'DELETED' => Xeroid::Objects::Invoice::Status::DELETED,
        'PAID' => Xeroid::Objects::Invoice::Status::PAID
      }

      object_class Objects::Invoice

      as_string   :id => 'InvoiceID',
                  :invoice_number => 'InvoiceNumber',
                  :currency_code => 'CurrencyCode',
                  :reference => 'Reference'

      as_currency :sub_total => 'SubTotal',
                  :total => 'Total',
                  :total_tax => 'TotalTax',
                  :amount_due => 'AmountDue',
                  :amount_paid => 'AmountPaid',
                  :amount_credited => 'AmountCredited'

      as_value    :type => ['Type', TYPES],
                  :status => ['Status', STATUSES]

      as_date     :date => 'Date',
                  :due_date => 'DueDate'

      child       :contact => ['Contact', Deserialisers::Contact]

      children    :line_items => ['LineItems/LineItem', Deserialisers::LineItem]

      as_utc_timestamp :updated_date_utc => 'UpdatedDateUTC'
    end
  end
end
