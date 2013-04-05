require 'spec_helper'

require 'ostruct'
require 'xeroid/deserialisers/extractors'

module Xeroid::Deserialisers
  describe Extractors do
    describe "straight-text attributes" do
      let(:xml) { '<r><a>A string</a><b>B string</b></r>' }
      let(:klass) { Class.new { include Extractors; object_class OpenStruct; as_string :thing => '/r/a' } }
      let(:instance) { klass.deserialise_one(xml) }

      it "can extract a value" do
        instance.thing.should == "A string"
      end

      context "several values" do
        let(:klass) { Class.new { include Extractors; object_class OpenStruct; as_string :a => '/r/a', :b => '/r/b' } }

        it "can extract the first value" do
          instance.a.should == 'A string'
        end

        it "can extract the second value" do
          instance.b.should == 'B string'
        end
      end

      context "missing values" do
        let(:klass) { Class.new { include Extractors; object_class OpenStruct; as_string :a => '/r/a', :c => '/r/c' } }

        it "extracts the first value" do
          instance.a.should == 'A string'
        end

        it "doesn't attempt to set the second" do
          instance.should_not respond_to(:c)
        end
      end
    end

    describe "currency attributes" do
      let(:xml) { '<r><a>10.00</a><b>20.00</b></r>' }
      let(:klass) { Class.new { include Extractors; object_class OpenStruct; as_currency :thing => '/r/a' } }
      let(:instance) { klass.deserialise_one(xml) }
      let(:ten) { BigDecimal.new("10.00")  }
      let(:twenty) { BigDecimal.new("20.00") }

      it "can extract a value" do
        instance.thing.should == ten
      end

      context "several values" do
        let(:klass) { Class.new { include Extractors; object_class OpenStruct; as_currency :a => '/r/a', :b => '/r/b' } }

        it "can extract the first value" do
          instance.a.should == ten
        end

        it "can extract the second value" do
          instance.b.should == twenty
        end
      end

      context "missing values" do
        let(:klass) { Class.new { include Extractors; object_class OpenStruct; as_currency :a => '/r/a', :c => '/r/c' } }

        it "extracts the first value" do
          instance.a.should == ten
        end

        it "doesn't attempt to set the second" do
          instance.should_not respond_to(:c)
        end
      end
    end
  end
end
