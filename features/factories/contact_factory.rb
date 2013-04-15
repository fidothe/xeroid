FactoryGirl.define do
  initialize_with { new(attributes) }

  factory :minimal_draft_contact, class: Xeroid::Objects::Contact do
    name "Test Company"
  end

  factory :valid_contact, class: Xeroid::Objects::Contact do
    name "Detailed Test Company"
    email_address "dtc@example.com"
    first_name "Joe"
    last_name "Customer"
    addresses { FactoryGirl.build(:full_addresses) }
    tax_number "GB12341200"
  end
end
