FactoryGirl.define do
  initialize_with { new(attributes) }

  factory :minimal_draft_invoice, class: Xeroid::Objects::Invoice do
    type Xeroid::Objects::Invoice::Type::ACCPAY
    contact { FactoryGirl.build(:minimal_draft_contact) }
    line_items { [FactoryGirl.build(:minimal_line_item)] }
  end

  factory :invalid_draft_invoice, class: Xeroid::Objects::Invoice do
    contact { FactoryGirl.build(:minimal_draft_contact) }
    line_items []
  end
end
