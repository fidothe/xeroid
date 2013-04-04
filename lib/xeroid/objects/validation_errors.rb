module Xeroid
  module Objects
    class ValidationErrors
      attr_reader :errors

      def initialize(errors)
        @errors = errors.dup.freeze
      end
    end
  end
end
