require 'spec_helper'

require 'xeroid/objects/attributes'

module Xeroid::Objects
  describe Attributes do
    describe "Currency value attributes (Decimals)" do
      it "sets up an attribute which accepts a BigDecimal" do
        klass = Class.new { include Attributes; big_decimal(:thing) }
        object = klass.new(thing: BigDecimal.new("20.00"))
        object.thing.should == BigDecimal.new("20.00")
      end
    end
  end
end
