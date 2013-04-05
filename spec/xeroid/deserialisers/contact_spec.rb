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
      let(:result) { Contact.deserialise_one(read_xml_fixture('simple_contact')) }

      it "correctly extracts the id" do
        result.id.should == "c710c4b0-fb6b-48b6-b5de-82ed7ffcc6de"
      end
    end
  end
end
