require 'xeroid/objects'
require 'xeroid/deserialisers/extractors'

module Xeroid
  module Deserialisers
    class Contact
      include Extractors
      
      root_node 'Contacts/Contact'

      object_class Objects::Contact

      as_string :id => 'ContactID',
                :name => 'Name'
    end
  end
end
