require 'spec_helper'

require 'xeroid/objects/invoice'

module Xeroid::Objects
  describe Invoice do
    let(:invoice) { Invoice.new(id: "abcde-12345-abcde-12345") }

    it "can return its code" do
      invoice.id.should == "abcde-12345-abcde-12345"
    end
  end
end
