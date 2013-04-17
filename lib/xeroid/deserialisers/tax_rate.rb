require 'xeroid/objects'
require 'xeroid/deserialisers/extractors'

module Xeroid
  module Deserialisers
    class TaxRate
      include Extractors

      root_node 'TaxRates/TaxRate'

      object_class Objects::TaxRate

      as_string   :name => 'Name',
                  :tax_type => 'TaxType'

      as_currency :display_tax_rate => 'DisplayTaxRate',
                  :effective_tax_rate => 'EffectiveRate'

      as_boolean  :can_apply_to_assets => 'CanApplyToAssets',
                  :can_apply_to_equity => 'CanApplyToEquity',
                  :can_apply_to_expenses => 'CanApplyToExpenses',
                  :can_apply_to_liabilities => 'CanApplyToLiabilities',
                  :can_apply_to_revenue => 'CanApplyToRevenue'
    end
  end
end
