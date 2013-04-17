require 'xeroid/objects/attributes'

module Xeroid
  module Objects
    class LineItem
      include Attributes

      attribute :description, :quantity, :account, :tax_type
      big_decimal :unit_amount, :line_amount, :tax_amount
    end
  end
end
