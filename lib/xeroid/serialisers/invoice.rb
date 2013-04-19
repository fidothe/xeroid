require 'builder'
require 'xeroid/serialisers/contact'

module Xeroid
  module Serialisers
    class Invoice
      LINE_AMOUNT_TYPES = {
        exclusive: "Exclusive"
      }

      def self.serialise_one(invoice)
        xml = Builder::XmlMarkup.new(:indent=>2)
        xml.instruct!

        serialise(invoice, xml)

        xml.target!
      end

      def self.serialise_many(invoices)
        xml = Builder::XmlMarkup.new(:indent=>2)
        xml.instruct!

        xml.Invoices do |xml|
          invoices.each do |invoice|
            serialise(invoice, xml)
          end
        end

        xml.target!
      end

      private

      def self.serialise(invoice, xml)
        xml.Invoice do |xml|
          xml.Type invoice.type.to_s.upcase
          xml.InvoiceNumber invoice.invoice_number if invoice.invoice_number
          Xeroid::Serialisers::Contact.serialise(invoice.contact, xml)
          xml.Date invoice.date.strftime("%Y-%m-%dT00:00:00") if invoice.date
          xml.DueDate invoice.due_date.strftime("%Y-%m-%dT00:00:00") if invoice.due_date
          xml.Reference invoice.reference if invoice.reference
          xml.LineAmountTypes LINE_AMOUNT_TYPES[invoice.line_amount_types]
          xml.LineItems do |xml|
            invoice.line_items.each do |line_item|
              xml.LineItem do |xml|
                xml.Description line_item.description
                xml.UnitAmount line_item.unit_amount.to_s("F")
                xml.TaxType line_item.tax_type.tax_type if line_item.tax_type
                xml.TaxAmount line_item.tax_amount.to_s("F") if line_item.tax_amount
                xml.LineAmount line_item.line_amount.to_s("F") if line_item.line_amount
                xml.AccountCode line_item.account.code
                xml.Quantity line_item.quantity.to_s
              end
            end
          end
          xml.Status invoice.status.to_s.upcase
        end
      end
    end
  end
end
