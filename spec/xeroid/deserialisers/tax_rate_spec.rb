require 'spec_helper'

require 'xeroid/deserialisers/tax_rate'
require 'bigdecimal'

module Xeroid::Deserialisers
  describe TaxRate do
    it "reports its object class is Xeroid::Objects::Contact" do
      TaxRate.object_class.should be(Xeroid::Objects::TaxRate)
    end

    it "reports the xpath to the Contact root node" do
      TaxRate.content_node_xpath.should == '/Response/TaxRates/TaxRate'
    end

    describe "a tax rate" do
      let(:tax_rate) { TaxRate.deserialise_one(read_xml_fixture('tax_rate')) }

      it "correctly extracts the name" do
        tax_rate.name.should == "19% VAT on sales"
      end

      it "correctly extracts the tax type" do
        tax_rate.tax_type.should == "TAX002"
      end

      it "correctly extracts CanApplyToAssets" do
        tax_rate.can_apply_to_assets?.should be_true
      end

      it "correctly extracts CanApplyToEquity" do
        tax_rate.can_apply_to_equity?.should be_true
      end

      it "correctly extracts CanApplyToExpenses" do
        tax_rate.can_apply_to_expenses?.should be_true
      end

      it "correctly extracts CanApplyToLiabilities" do
        tax_rate.can_apply_to_liabilities?.should be_true
      end

      it "correctly extracts CanApplyToRevenue" do
        tax_rate.can_apply_to_revenue?.should be_true
      end

      it "correctly extracts the display tax rate" do
        tax_rate.display_tax_rate.should == BigDecimal.new("19.0")
      end

      it "correctly extracts the effective tax rate" do
        tax_rate.effective_tax_rate.should == BigDecimal.new("19.0")
      end
    end
  end
end
