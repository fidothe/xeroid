require 'spec_helper'

require 'xeroid/objects/tax_rate'

module Xeroid::Objects
  describe TaxRate do
    let(:attrs) { {
      name: 'VAT on expenses', tax_type: 'TAX002',
      display_tax_rate: BigDecimal.new("20.00"), effective_tax_rate: BigDecimal.new("20.00"),
      can_apply_to_assets: true, can_apply_to_revenue: true, can_apply_to_equity: true,
      can_apply_to_liabilities: false, can_apply_to_expenses: false
    } }
    let(:tax_rate) { TaxRate.new(attrs) }

    it "can return its name" do
      tax_rate.name.should == 'VAT on expenses'
    end

    it "can return the tax type" do
      tax_rate.tax_type.should == 'TAX002'
    end

    it "can return the effective tax rate" do
      tax_rate.effective_tax_rate.should == BigDecimal.new("20.00")
    end

    it "can return the display tax rate" do
      tax_rate.display_tax_rate.should == BigDecimal.new("20.00")
    end

    it "can return whether it can apply to assets" do
      tax_rate.can_apply_to_assets?.should be_true
    end

    it "can return whether it can apply to revenue" do
      tax_rate.can_apply_to_revenue?.should be_true
    end

    it "can return whether it can apply to equity" do
      tax_rate.can_apply_to_equity?.should be_true
    end

    it "can return whether it can apply to liabilities" do
      tax_rate.can_apply_to_liabilities?.should be_false
    end

    it "can return whether it can apply to expenses" do
      tax_rate.can_apply_to_expenses?.should be_false
    end
  end
end
