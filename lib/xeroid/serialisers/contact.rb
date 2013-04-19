require 'builder'

module Xeroid
  module Serialisers
    class Contact
      def self.serialise_one(contact)
        xml = Builder::XmlMarkup.new(:indent=>2)
        xml.instruct!

        serialise(contact, xml)

        xml.target!
      end

      def self.serialise_many(contacts)
        xml = Builder::XmlMarkup.new(:indent=>2)
        xml.instruct!

        xml.Contacts do |xml|
          contacts.each do |contact|
            serialise(contact, xml)
          end
        end

        xml.target!
      end

      def self.serialise(contact, xml)
        xml.Contact do |xml|
          xml.ContactID contact.id if contact.id
          xml.Name contact.name if contact.name
          xml.FirstName contact.first_name if contact.first_name
          xml.LastName contact.last_name if contact.last_name
          xml.EmailAddress contact.email_address if contact.email_address
          if !contact.addresses.empty?
            xml.Addresses do |xml|
              serialise_address(xml, contact.addresses.pobox) if !contact.addresses.pobox.empty?
              serialise_address(xml, contact.addresses.street) if !contact.addresses.street.empty?
            end
          end
        end
      end

      private

      def self.serialise_address(xml, address)
        xml.Address do |xml|
          xml.AddressType address.type.to_s.upcase
          address.address_lines.each_with_index do |line, i|
            xml.tag!("AddressLine#{i + 1}", line)
          end
          xml.City address.city if address.city
          xml.Region address.region if address.region
          xml.Country address.country if address.country
          xml.PostalCode address.postal_code if address.postal_code
          xml.AttentionTo address.attention_to if address.attention_to
        end
      end
    end
  end
end
