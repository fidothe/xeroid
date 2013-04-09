require 'xeroid/objects'
require 'xeroid/deserialisers/extractors'

module Xeroid
  module Deserialisers
    class Account
      include Extractors

      object_class Objects::Account

      as_string :code => 'Code'
    end
  end
end
