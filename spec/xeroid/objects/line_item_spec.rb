require 'spec_helper'

require 'xeroid/objects/line_item'
require 'bigdecimal'

module Xeroid::Objects
  describe LineItem do
    let(:unit_amount) { BigDecimal.new('10.00') }
    let(:attrs) { {description: 'The line item', quantity: 5, unit_amount: unit_amount} }
    let(:line_item) { LineItem.new(attrs) }

    it "can return its description" do
      line_item.description.should == 'The line item'
    end

    it "can return its quantity" do
      line_item.quantity.should == 5
    end

    it "can return its unit amount" do
      line_item.unit_amount.should == unit_amount
    end

    it "does not accept a non-BigDecimal unit amount" do
      expect { LineItem.new(unit_amount: "10.00") }.to raise_error(Attributes::NotABigDecimal)
    end
  end
end
