require 'xeroid/deserialisers/api_exception'

module Xeroid
  class APIResponse
    OKAY = 0
    API_EXCEPTION = 1

    def self.content_root_nodeset(content_node_xpath, xml_string)
      Nokogiri::XML(xml_string).xpath(content_node_xpath)
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
        object = deserialiser.deserialise_from_node(node)
        new(object, OKAY)
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
