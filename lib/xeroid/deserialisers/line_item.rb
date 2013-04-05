require 'xeroid/objects'
require 'xeroid/deserialisers/extractors'

module Xeroid
  module Deserialisers
    class LineItem
      include Extractors
      
      object_class Objects::LineItem

      as_string   :description => 'Description'
      as_number   :quantity => 'Quantity'
    end
  end
end
