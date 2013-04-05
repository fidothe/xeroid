require 'spec_helper'

require 'ostruct'
require 'xeroid/deserialisers/extractors'

module Xeroid::Deserialisers
  describe Extractors do
    describe "straight-text attributes" do
      let(:xml) { '<r><a>A string</a><b>B string</b></r>' }
      let(:klass) { Class.new { include Extractors; object_class OpenStruct; as_string :thing => '/r/a' } }

      it "can extract a value" do
        instance = klass.deserialise_one(xml)
        instance.thing.should == "A string"
      end
    end
  end
end
