require 'xeroid/objects/attributes'

module Xeroid
  module Objects
    class LineItem
      include Attributes

      attribute :description, :quantity, :account
      big_decimal :unit_amount
    end
  end
end
