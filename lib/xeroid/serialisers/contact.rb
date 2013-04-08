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

      private

      def self.serialise(contact, xml)
        xml.Contact do |xml|
          xml.Name contact.name
        end
      end
    end
  end
end
