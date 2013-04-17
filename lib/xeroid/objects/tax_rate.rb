require 'xeroid/objects/attributes'

module Xeroid
  module Objects
    class TaxRate
      include Attributes

      attribute :name, :tax_type
      big_decimal :display_tax_rate, :effective_tax_rate
      boolean :can_apply_to_assets, :can_apply_to_equity, :can_apply_to_expenses, :can_apply_to_liabilities, :can_apply_to_revenue
    end
  end
end
