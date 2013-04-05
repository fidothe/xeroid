module Xeroid
  module Deserialisers
    autoload :Invoice, 'xeroid/deserialisers/invoice'
    autoload :LineItem, 'xeroid/deserialisers/line_item'
    autoload :Contact, 'xeroid/deserialisers/contact'
    autoload :APIException, 'xeroid/deserialisers/api_exception'
  end
end
