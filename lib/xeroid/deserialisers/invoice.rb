require 'xeroid/objects'
require 'nokogiri'
require 'date'

module Xeroid
  module Deserialisers
    class Invoice
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
      def self.deserialise_one(xml)
        doc = Nokogiri::XML(xml)
        new(doc).deserialise
      end

      def initialize(document)
        @document = document
      end

      def extract_text(xpath)
        @document.xpath(xpath).text
      end

      def extract_value(xpath, values)
        values[extract_text(xpath)]
      end

      def extract_date(xpath)
        date_string = extract_text(xpath)
        Date.parse(date_string)
      end

      def extract_currency(xpath)
        BigDecimal.new(extract_text(xpath))
      end

      def deserialise
        attributes = {}
        # core attributes
        attributes[:id] = extract_text('/Invoices/Invoice/InvoiceID')
        attributes[:type] = extract_value('/Invoices/Invoice/Type', TYPES)
        attributes[:date] = extract_date('/Invoices/Invoice/Date')
        attributes[:due_date] = extract_date('/Invoices/Invoice/DueDate')
        attributes[:status] = extract_value('/Invoices/Invoice/Status', STATUSES)
        attributes[:sub_total] = extract_currency('/Invoices/Invoice/SubTotal')

        Objects::Invoice.new(attributes)
      end
    end
  end
end
