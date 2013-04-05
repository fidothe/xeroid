require 'spec_helper'

require 'ostruct'
require 'nokogiri'
require 'xeroid/deserialisers/extractors'

module Xeroid::Deserialisers
  describe Extractors do
    describe Extractors::Extractor do
      let(:xml) { '<r>
        <s>A string</s><c>10.00</c>
        <d>2013-04-05T00:00:00</d><ut>2013-04-05T06:07:08.901</ut>
        <t>CONSTRAINED</t><bad_t>Unconstrained</bad_t>
      </r>' }
      let(:doc) { Nokogiri::XML(xml) }
      let(:x) { Extractors::Extractor.new(doc) }

      context "string values" do
        it "can extract a value" do
          x.extract_string('/r/s').should == 'A string'
        end

        it "returns nil for a missing value" do
          x.extract_string('/r/null').should be_nil
        end
      end

      context "currency values" do
        it "can extract a value" do
          x.extract_currency('/r/c').should == BigDecimal.new("10.00")
        end

        it "returns nil for a missing value" do
          x.extract_currency('/r/null').should be_nil
        end
      end

      context "date values" do
        it "can extract a value" do
          x.extract_date('/r/d').should == Date.new(2013, 4, 5)
        end

        it "returns nil for a missing value" do
          x.extract_date('/r/null').should be_nil
        end
      end

      context "UTC timestamp values" do
        it "can extract a value" do
          x.extract_utc_timestamp('/r/ut').should == Time.xmlschema("2013-04-05T08:07:08.901+02:00")
        end

        it "returns nil for a missing value" do
          x.extract_utc_timestamp('/r/null').should be_nil
        end
      end

      context "constrained values" do
        let(:values) { {'CONSTRAINED' => :result} }

        it "can extract a value" do
          x.extract_value('/r/t', values).should == :result
        end

        it "returns nil for a missing value" do
          x.extract_value('/r/null', values).should be_nil
        end

        it "returns nil for an incorrect value" do
          x.extract_value('/r/bad_t', values).should be_nil
        end
      end

      describe "using mappings" do
        it "can extract a specific kind of value using a mapping" do
          attributes = {}
          x.extract_from_mapping({:thing => '/r/s'}, :string, attributes)
          attributes[:thing].should == 'A string'
        end

        context "many-value mappings" do
          let(:xml) { '<r><a>A string</a><b>B string</b></r>' }

          it "can extract several values" do
            attributes = {}
            x.extract_from_mapping({:a => '/r/a', :b => '/r/b'}, :string, attributes)
            attributes[:a].should == 'A string'
            attributes[:b].should == 'B string'
          end
        end

        it "ignores empty-result xpaths" do
          attributes = {}
          x.extract_from_mapping({:thing => '/r/null'}, :string, attributes)
          attributes.should_not have_key(:thing)
        end

        it "ignores nil mappings" do
          attributes = {}
          x.extract_from_mapping(nil, :string, attributes)
          attributes.should be_empty
        end
      end
    end

    describe "reporting the path to the root content node in the response XML" do
      it "correctly reports given a plain relative path" do
        klass = Class.new { include Extractors; root_node 'Invoices/Invoice' }
        klass.content_node_xpath.should == '/Response/Invoices/Invoice'
      end

      it "correctly reports given a rooted path" do
        klass = Class.new { include Extractors; root_node '/Invoices/Invoice' }
        klass.content_node_xpath.should == '/Invoices/Invoice'
      end

      it "reports / when unused" do
        klass = Class.new { include Extractors }
        klass.content_node_xpath.should == '/'
      end
    end

    describe "straight-text attributes" do
      let(:xml) { '<r><a>A string</a><b>B string</b></r>' }
      let(:klass) { Class.new { include Extractors; object_class OpenStruct; as_string :thing => '/r/a' } }

      it "can extract a value" do
        klass.deserialise_one(xml).thing.should == "A string"
      end
    end

    describe "currency attributes" do
      let(:xml) { '<r><a>10.00</a><b>20.00</b></r>' }
      let(:klass) { Class.new { include Extractors; object_class OpenStruct; as_currency :thing => '/r/a' } }
      let(:ten) { BigDecimal.new("10.00")  }

      it "can extract a value" do
        klass.deserialise_one(xml).thing.should == ten
      end
    end

    describe "date attributes" do
      let(:xml) { '<r><a>2013-04-05T00:00:00</a></r>' }
      let(:klass) { Class.new { include Extractors; object_class OpenStruct; as_date :thing => '/r/a' } }

      it "can extract a value" do
        klass.deserialise_one(xml).thing.should == Date.new(2013, 4, 5)
      end
    end

    describe "UTC timestamp values" do
      let(:xml) { '<r><a>2013-04-05T06:07:08</a><rfc3339>2013-04-05T06:07:08Z</rfc3339></r>' }
      let(:klass) { Class.new { include Extractors; object_class OpenStruct; as_utc_timestamp :a => '/r/a', :b => '/r/rfc3339' } }

      it "can extract the usual UpdatedDateUTC style slightly-malformed iso8601 datetime" do
        klass.deserialise_one(xml).a.should == Time.utc(2013, 4, 5, 6, 7, 8)
      end

      it "can extract a correctly formed ISO8601/RFC 3339 datetime" do
        klass.deserialise_one(xml).b.should == Time.utc(2013, 4, 5, 6, 7, 8)
      end
    end

    describe "Constrained values" do
      let(:xml) { '<r><a>ACCREC</a></r>' }
      let(:klass) { Class.new { include Extractors; object_class OpenStruct; as_value :thing => ['/r/a', {'ACCREC' => :receivable}] } }

      it "can extract a value" do
        klass.deserialise_one(xml).thing.should == :receivable
      end
    end

    describe "deserialising docs with a deeper content root node" do
      let(:xml) { '<wrapper><r><a>A string</a><b>B string</b></r></wrapper>' }
      let(:klass) { Class.new { include Extractors; root_node '/wrapper/r'; object_class OpenStruct; as_string :thing => 'a' } }

      it "can extract a value" do
        klass.deserialise_one(xml).thing.should == "A string"
      end
    end
  end
end
