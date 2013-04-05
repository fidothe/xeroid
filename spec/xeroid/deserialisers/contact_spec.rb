require 'spec_helper'

require 'xeroid/deserialisers/contact'

module Xeroid::Deserialisers
  describe Contact do
    it "reports its object class is Xeroid::Objects::Contact" do
      Contact.object_class.should be(Xeroid::Objects::Contact)
    end

    it "reports the xpath to the Contact root node" do
      Contact.content_node_xpath.should == '/Response/Contacts/Contact'
    end

    describe "a simple contact" do
      let(:contact) { Contact.deserialise_one(read_xml_fixture('simple_contact')) }

      it "correctly extracts the id" do
        contact.id.should == "c710c4b0-fb6b-48b6-b5de-82ed7ffcc6de"
      end

      it "correctly extracts the name" do
        contact.name.should == "Test Co"
      end
    end

    describe "being processed as a child of a container document (e.g. an Invoice)" do
      it "can be correctly deserialised" do
        doc = Nokogiri::XML(read_xml_fixture('simple_invoice'))
        contact_root = doc.xpath('/Response/Invoices/Invoice/Contact')
        result = Contact.deserialise_from_node(contact_root)
      end
    end
  end
end
