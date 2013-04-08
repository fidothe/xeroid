require 'spec_helper'

require 'xeroid/api_response'

module Xeroid
  describe APIResponse do
    let(:deserialiser) { stub("Xeroid::Deserialisers::Thing", :content_node_xpath => '/Some/Api') }
    let(:object) { stub("Xeroid::Objects::Thing") }
    let(:response) { stub("Xeroid::APIResponse") }
    let(:response_body ) { "<Some><Api><XML/></Api></Some>" }

    context "general processing" do
      it "can fetch a nodeset containing the root node(s) of the content-holding part of the doc" do
        nodeset = APIResponse.content_root_nodeset('/Some/Api', response_body)
        nodeset.length.should == 1
        nodeset.first.name.should == 'Api'
      end

      context "checking the status attribute of a content-root element to see if it's okay" do
        it "reports that status='OK' is okay" do
          stub_node = {'status' => 'OK'}
          APIResponse.object_okay?(stub_node).should be_true
        end

        it "reports that status='error' is not okay" do
          stub_node = {'status' => 'ERROR'}
          APIResponse.object_okay?(stub_node).should be_false
        end

        it "reports that node without status attr is okay" do
          stub_node = {}
          APIResponse.object_okay?(stub_node).should be_true
        end
      end
    end

    context "HTTP 200 response" do
      let(:http_response) { stub("Net::HTTPResponse", code: "200", body: response_body) }

      it "parses the XML and returns the correct nodeset for deserialisation" do
        nodeset = stub("Nokogiri::XML::Nodeset")
        deserialiser.stub(:deserialise_from_node).with(nodeset).and_return(object)

        APIResponse.should_receive(:content_root_nodeset).with(deserialiser.content_node_xpath, response_body).and_return(nodeset)

        APIResponse.handle_one_response(deserialiser, http_response)
      end

      it "can handle a successful API response where the expected output is a single object" do
        nodeset = stub("Nokogiri::XML::Nodeset")
        APIResponse.stub(:content_root_nodeset) { nodeset }
        deserialiser.stub(:deserialise_from_node).with(nodeset).and_return(object)

        APIResponse.should_receive(:new).with(object, APIResponse::OKAY).and_return(response)

        APIResponse.handle_one_response(deserialiser, http_response).should == response
      end

      context "where the expected output is many objects" do
        let(:node) { stub("Nokogiri::XML::Node") }

        it "can handle a successful API response to a GET where the expected output is many objects" do
          nodeset = [node]
          APIResponse.stub(:content_root_nodeset) { nodeset }
          APIResponse.stub(:object_okay?).with(node).and_return(true)
          deserialiser.stub(:deserialise_from_node).with(node).and_return(object)

          APIResponse.should_receive(:new).with(object, APIResponse::OKAY).and_return(response)

          APIResponse.handle_many_response(deserialiser, http_response).should == [response]
        end

        it "can handle an API response with several objects, one of which would cause an HTTP 400 if posted by itself" do
          bad_node = stub("Nokogiri::XML::Node")
          nodeset = [node, bad_node]
          exception_object = stub('Xeroid::Objects::ValidationErrors')
          exception_response = stub('Xeroid::APIResponse')
          APIResponse.stub(:content_root_nodeset) { nodeset }
          APIResponse.stub(:object_okay?).with(node).and_return(true)
          deserialiser.stub(:deserialise_from_node).with(node).and_return(object)
          APIResponse.stub(:object_okay?).with(bad_node).and_return(false)
          Xeroid::Deserialisers::APIException.stub(:deserialise_from_node).with(bad_node).and_return(exception_object)

          APIResponse.should_receive(:new).with(object, APIResponse::OKAY).and_return(response)
          APIResponse.should_receive(:new).with(exception_object, APIResponse::API_EXCEPTION).and_return(exception_response)

          APIResponse.handle_many_response(deserialiser, http_response).should == [response, exception_response]
        end
      end
    end

    context "HTTP 400 response" do
      let(:http_response) { stub("Net::HTTPResponse", code: "400", body: response_body) }

      it "can handle an unsuccessful response (400 implies single object)" do
        nodeset = stub("Nokogiri::XML::Nodeset")
        APIResponse.stub(:content_root_nodeset).with(Xeroid::Deserialisers::APIException.content_node_xpath, response_body).and_return(nodeset)
        Xeroid::Deserialisers::APIException.stub(:deserialise_from_node).with(nodeset).and_return(object)

        APIResponse.should_receive(:new).with(object, APIResponse::API_EXCEPTION).and_return(response)

        APIResponse.handle_one_response(deserialiser, http_response).should == response
      end
    end

    describe "instances" do
      let(:response) { APIResponse.new(object, APIResponse::OKAY) }

      it "can return their status" do
        response.status.should == APIResponse::OKAY
      end

      it "can return their object" do
        response.object.should == object
      end

      it "reports that it's okay" do
        response.okay?.should be_true
      end

      context "instances that are not okay" do
        it "reports that it's not okay" do
          response = APIResponse.new(object, APIResponse::API_EXCEPTION)
          response.okay?.should be_false
        end
      end
    end
  end
end
