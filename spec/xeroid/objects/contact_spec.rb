require 'spec_helper'

require 'xeroid/objects/contact'

module Xeroid::Objects
  describe Contact do
    let(:attrs) { {name: 'AB Contacts', first_name: 'Albert', last_name: 'Contact'} }
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
  end
end
