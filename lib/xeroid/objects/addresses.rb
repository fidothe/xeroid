require 'xeroid/objects/attributes'

module Xeroid
  module Objects
    class Addresses
      include Attributes

      attribute :pobox, :street
    end
  end
end
