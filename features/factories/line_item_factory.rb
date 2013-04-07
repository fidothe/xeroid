FactoryGirl.define do
  initialize_with { new(attributes) }

  factory :minimal_line_item, class: Xeroid::Objects::LineItem do
    account Xeroid::Objects::Account.new(code: "200")
    description "Item"
    quantity 1
    unit_amount BigDecimal.new("10.00")
  end

end
