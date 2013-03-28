require 'spec_helper'

require 'xeroid/objects/attributes'

module Xeroid::Objects
  describe Attributes do
    describe "Currency value attributes (Decimals)" do
      let(:klass) { Class.new { include Attributes; big_decimal(:thing) } }

      it "sets up an attribute which accepts a BigDecimal" do
        object = klass.new(thing: BigDecimal.new("20.00"))
        object.thing.should == BigDecimal.new("20.00")
      end

      it "raises NotABigDecimal if you try to create the attribute with a String (even though it's a valid arg for BigDecimal.new)" do
        expect { klass.new(thing: "20.00") }.to raise_error(Attributes::NotABigDecimal)
      end

      it "raises NotABigDecimal if you try to create the attribute with an Integer" do
        expect { klass.new(thing: 20) }.to raise_error(Attributes::NotABigDecimal)
      end

      it "raises NotABigDecimal if you try to create the attribute with a Float" do
        expect { klass.new(thing: 20.0) }.to raise_error(Attributes::NotABigDecimal)
      end
    end
  end
end
