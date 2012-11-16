require 'builder'

module Xeroid
  module Serializers
    class Payment
      def self.serialize(payment)
        xml = Builder::XmlMarkup.new(:indent=>2)
        xml.instruct!
        xml.Payments do |xml|
          xml.Payment do |xml|
            xml.Invoice do |xml|
              xml.InvoiceID payment.invoice.id
            end
            xml.Account do |xml|
              xml.Code payment.account.code
            end
            xml.Date payment.date.strftime("%Y-%m-%dT00:00:00")
            xml.Amount payment.amount.to_s
          end
        end

        xml.target!
      end
    end
  end
end
