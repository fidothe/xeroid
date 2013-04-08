require 'xeroid/deserialisers/api_exception'

module Xeroid
  class APIResponse
    OKAY = 0
    API_EXCEPTION = 1

    def self.content_root_nodeset(content_node_xpath, xml_string)
      Nokogiri::XML(xml_string).xpath(content_node_xpath)
    end

    def self.object_okay?(node)
      return true if node['status'].nil?
      node['status'] == "OK"
    end

    def self.handle_one_response(deserialiser, http_response)
      case http_response.code
      when "200"
        status = OKAY
      when "400"
        deserialiser = ::Xeroid::Deserialisers::APIException
        status = API_EXCEPTION
      end
      object = deserialiser.deserialise_from_node(content_root_nodeset(deserialiser.content_node_xpath, http_response.body))
      new(object, status)
    end

    def self.handle_many_response(deserialiser, http_response)
      nodeset = content_root_nodeset(deserialiser.content_node_xpath, http_response.body)
      
      nodeset.collect { |node|
        if object_okay?(node)
          object = deserialiser.deserialise_from_node(node)
          status = OKAY
        else
          object = ::Xeroid::Deserialisers::APIException.deserialise_from_node(node)
          status = API_EXCEPTION
        end
        new(object, status)
      }
    end

    attr_reader :object, :status

    def initialize(object, status)
      @object = object
      @status = status
    end

    def okay?
      status === OKAY
    end
  end
end
