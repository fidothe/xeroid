require 'spec_helper'

require 'xeroid/objects/contact'

module Xeroid::Objects
  describe Contact do
    let(:attrs) { {id: 'abcde-12345-abcde-12345', name: 'AB Contacts', first_name: 'Albert', last_name: 'Contact', email_address: 'contact@example.com', tax_number: 'GB12341200'} }
    let(:contact) { Contact.new(attrs) }

    it "can return its id" do
      contact.id.should == 'abcde-12345-abcde-12345'
    end

    it "can return its name" do
      contact.name.should == 'AB Contacts'
    end

    it "can return the first name of a contact person" do
      contact.first_name.should == 'Albert'
    end

    it "can return the last name of a contact person" do
      contact.last_name.should == 'Contact'
    end

    it "can return the email address of a contact" do
      contact.email_address.should == 'contact@example.com'
    end

    it "can return its tax number" do
      contact.tax_number.should == 'GB12341200'
    end

    it "has no addresses by default" do
      contact.addresses.should be_instance_of(EmptyAddresses)
    end

    describe "addresses" do
      let(:addresses) { stub('Addresses') }
      let(:attrs) { {addresses: addresses} }

      it "can return its addresses" do
        contact.addresses.should == addresses
      end
    end
  end
end
