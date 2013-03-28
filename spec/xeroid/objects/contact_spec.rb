require 'spec_helper'

require 'xeroid/objects/contact'

module Xeroid::Objects
  describe Contact do
    let(:attrs) { {name: "AB Contacts"} }
    let(:contact) { Contact.new(attrs) }

    it "can return its name" do
      contact.name.should == "AB Contacts"
    end
  end
end
