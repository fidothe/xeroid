require 'builder'

module Xeroid
  module Serialisers
    class Invoice
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
          xml.Contact do |xml|
            xml.Name invoice.contact.name
          end
          xml.Date invoice.date.strftime("%Y-%m-%dT00:00:00") if invoice.date
          xml.DueDate invoice.due_date.strftime("%Y-%m-%dT00:00:00") if invoice.due_date
          xml.LineItems do |xml|
            invoice.line_items.each do |line_item|
              xml.LineItem do |xml|
                xml.Description line_item.description
                xml.UnitAmount line_item.unit_amount.to_s("F")
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
