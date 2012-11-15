require 'builder'

module Xeroid
  module Serializers
    class Payment
      def self.serialize(payment)
        xml = Builder::XmlMarkup.new
        xml.instruct!
        xml.Payments do |xml|
          xml.Payment do |xml|
            xml.Invoice do |xml|
              xml.InvoiceID payment.invoice.id
            end
            xml.Account do |xml|
              xml.Code payment.account.code
            end
            xml.Date payment.date.strftime("%Y-%m-%d")
            xml.Amount payment.amount.to_s
          end
        end

        xml
      end
    end
  end
end
