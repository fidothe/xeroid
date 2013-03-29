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

      describe "passing multiple attribute names" do
        let(:klass) { Class.new { include Attributes; big_decimal(:this, :that) } }
        let(:instance) { klass.new(this: BigDecimal.new("10.00"), that: BigDecimal.new("20.00")) }

        it "sets the right value for 'this'" do
          instance.this.should == BigDecimal.new("10.00")
        end

        it "sets the right value for 'that'" do
          instance.that.should == BigDecimal.new("20.00")
        end
      end
    end

    describe "untyped attributes" do
      let(:klass) { Class.new { include Attributes; attribute(:thing) } }
      
      it "allows strings" do
        object = klass.new(thing: "value")
        object.thing.should == "value"
      end

      it "allows BigDecimal" do
        object = klass.new(thing: BigDecimal.new("20.00"))
        object.thing.should == BigDecimal.new("20.00")
      end

      describe "passing multiple attribute names" do
        let(:klass) { Class.new { include Attributes; attribute(:this, :that) } }
        let(:instance) { klass.new(this: BigDecimal.new("10.00"), that: "Value") }

        it "sets the right value for 'this'" do
          instance.this.should == BigDecimal.new("10.00")
        end

        it "sets the right value for 'that'" do
          instance.that.should == "Value"
        end
      end
    end

    describe "attributes with a defined set of allowed values" do
      module ConstrainedValue
        DRAFT = :draft
        AUTHORISED = :authorised

        VALID = [DRAFT, AUTHORISED]

        class Invalid < StandardError; end
      end

      let(:klass) { Class.new { include Attributes; constrained(thing: ConstrainedValue) } }

      it "can have its status set to DRAFT" do
        invoice = klass.new(thing: ConstrainedValue::DRAFT)
        invoice.thing.should == ConstrainedValue::DRAFT
      end

      it "can have its status set to AUTHORISED" do
        invoice = klass.new(thing: ConstrainedValue::AUTHORISED)
        invoice.thing.should == ConstrainedValue::AUTHORISED
      end

      it "cannot have its status set to anything else" do
        expect { klass.new(thing: "Absurd") }.to raise_error(ConstrainedValue::Invalid)
      end
    end
  end
end
