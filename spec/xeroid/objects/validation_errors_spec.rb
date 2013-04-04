require 'spec_helper'

require 'xeroid/objects/validation_errors'

module Xeroid::Objects
  describe ValidationErrors do
    it "returns its array of error messages" do
      messages = ["bad email", "bad other stuff"]
      errors = ValidationErrors.new(messages)

      errors.errors.should == messages
    end
  end
end
