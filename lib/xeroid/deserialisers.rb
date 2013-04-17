module Xeroid
  module Deserialisers
    autoload :Invoice, 'xeroid/deserialisers/invoice'
    autoload :LineItem, 'xeroid/deserialisers/line_item'
    autoload :Contact, 'xeroid/deserialisers/contact'
    autoload :Payment, 'xeroid/deserialisers/payment'
    autoload :Account, 'xeroid/deserialisers/account'
    autoload :TaxRate, 'xeroid/deserialisers/tax_rate'
    autoload :APIException, 'xeroid/deserialisers/api_exception'
  end
end
