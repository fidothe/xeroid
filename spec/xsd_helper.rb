require 'spec_helper'
require 'pathname'
require 'nokogiri'

RSpec::Matchers.define :validate_against do |name|
  def schema(name)
    ValidatorCache[name]
  end

  match do |xml_string|
    schema(name).valid?(Nokogiri::XML(xml_string))
  end

  failure_message_for_should do |xml_string|
    "expected the document to validate, but it didn't. Validation errors: \n  #{schema(name).validate(Nokogiri::XML(xml_string)).map { |e| e.message }.join("\n  ")}"
  end
end

class ValidatorCache
  class << self
    def schema_dir
      Pathname.new(File.expand_path("../../vendor/XeroAPI-Schemas/v2.00", __FILE__))
    end

    def fetch(name)
      validator_doc = (@validators || {})[name]
      return nil if validator_doc.nil?
      Nokogiri::XML::Schema.from_document(validator_doc)
    end

    def store(name, validator)
      (@validators ||= {})[name] = validator
    end

    def [](name)
      validator = fetch(name)
      return validator if validator
      store(name, Nokogiri::XML(File.open(schema_dir.join(name))))
      fetch(name)
    end
  end
end

def validator(name)
  ValidatorCache[name]
end
