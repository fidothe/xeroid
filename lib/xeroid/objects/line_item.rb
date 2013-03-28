require 'xeroid/objects/attributes'

module Xeroid
  module Objects
    class NotABigDecimal < StandardError; end

    class LineItem
      include Attributes

      attribute :description, :quantity
      big_decimal :unit_amount
    end
  end
end
