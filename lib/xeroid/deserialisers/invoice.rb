require 'xeroid/objects'
require 'xeroid/deserialisers/extractors'

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

      as_string   :id => '/Invoices/Invoice/InvoiceID',
                  :invoice_number => '/Invoices/Invoice/InvoiceNumber',
                  :currency_code => '/Invoices/Invoice/CurrencyCode'

      as_currency :sub_total => '/Invoices/Invoice/SubTotal',
                  :total => '/Invoices/Invoice/Total',
                  :total_tax => '/Invoices/Invoice/TotalTax',
                  :amount_due => '/Invoices/Invoice/AmountDue',
                  :amount_paid => '/Invoices/Invoice/AmountPaid',
                  :amount_credited => '/Invoices/Invoice/AmountCredited'

      as_value    :type => ['/Invoices/Invoice/Type', TYPES],
                  :status => ['/Invoices/Invoice/Status', STATUSES]

      as_date     :date => '/Invoices/Invoice/Date',
                  :due_date => '/Invoices/Invoice/DueDate'

      as_utc_timestamp :updated_date_utc => '/Invoices/Invoice/UpdatedDateUTC'
    end
  end
end
