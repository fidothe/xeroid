require 'spec_helper'

require 'xeroid/objects/contact'

module Xeroid::Objects
  describe Contact do
    let(:attrs) { {name: 'AB Contacts', first_name: 'Albert', last_name: 'Contact', email_address: 'contact@example.com'} }
    let(:contact) { Contact.new(attrs) }

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

    it "has no addresses by default" do
      contact.addresses.should be_instance_of(Contact::EmptyAddresses)
    end
  end
end
