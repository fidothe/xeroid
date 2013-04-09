require 'builder'

module Xeroid
  module Serialisers
    class Payment
      def self.serialise_one(payment)
        xml = Builder::XmlMarkup.new(:indent=>2)
        xml.instruct!

        xml.Payments do |xml|
          serialise(payment, xml)
        end

        xml.target!
      end

      def self.serialise_many(payments)
        xml = Builder::XmlMarkup.new(:indent=>2)
        xml.instruct!

        xml.Payments do |xml|
          payments.each do |payment|
            serialise(payment, xml)
          end
        end

        xml.target!
      end

      def self.serialise(payment, xml)
        xml.Payment do |xml|
          xml.Invoice do |xml|
            xml.InvoiceID payment.invoice.id
          end
          xml.Account do |xml|
            xml.Code payment.account.code
          end
          xml.Date payment.date.strftime("%Y-%m-%dT00:00:00")
          xml.Amount payment.amount.to_s("F")
          if payment.currency_rate
            xml.CurrencyRate payment.currency_rate.to_s("F")
          end
        end
      end
    end
  end
end
