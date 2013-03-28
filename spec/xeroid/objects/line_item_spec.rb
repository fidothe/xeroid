require 'spec_helper'

require 'xeroid/objects/line_item'

module Xeroid::Objects
  describe LineItem do
    let(:attrs) { {description: 'The line item', quantity: 5} }
    let(:line_item) { LineItem.new(attrs) }

    it "can return its description" do
      line_item.description.should == 'The line item'
    end

    it "can return its quantity" do
      line_item.quantity.should == 5
    end
  end
end
