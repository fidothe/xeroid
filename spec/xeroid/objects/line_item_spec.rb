require 'spec_helper'

require 'xeroid/objects'
require 'bigdecimal'

module Xeroid::Objects
  describe LineItem do
    let(:account) { Account.new(code: "200") }
    let(:unit_amount) { BigDecimal.new('20.00') }
    let(:line_amount) { BigDecimal.new('30.00') }
    let(:tax_amount) { BigDecimal.new('10.00') }
    let(:attrs) { {description: 'The line item', quantity: 5, unit_amount: unit_amount, line_amount: line_amount, tax_amount: tax_amount, account: account} }
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

    it "can return its tax amount" do
      line_item.tax_amount.should == tax_amount
    end

    it "can return its line amount" do
      line_item.line_amount.should == line_amount
    end

    it "can return its account" do
      line_item.account.should == account
    end
  end
end
