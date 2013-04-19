require 'xeroid/objects'
require 'xeroid/deserialisers/extractors'

module Xeroid
  module Deserialisers
    class LineItem
      include Extractors
      
      object_class Objects::LineItem

      as_string   :description => 'Description',
                  :tax_type => 'TaxType'

      as_number   :quantity => 'Quantity'

      as_currency :unit_amount => 'UnitAmount',
                  :tax_amount => 'TaxAmount',
                  :line_amount => 'LineAmount'
    end
  end
end
