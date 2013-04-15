FactoryGirl.define do
  initialize_with { new(attributes) }

  factory :full_addresses, class: Xeroid::Objects::Addresses do
    pobox { FactoryGirl.build(:full_pobox_address) }
    street { FactoryGirl.build(:full_street_address) }
  end

  factory :full_street_address, class: Xeroid::Objects::Address do
    type Xeroid::Objects::Address::Type::STREET
    address_lines ['4.OG', 'Aufgang 2', 'Hinterhof', 'Mehringdamm 222']
    city "Berlin"
    region "Berlin"
    postal_code "10999"
    country "Deutschland"
    attention_to "A. Customer"
  end

  factory :full_pobox_address, class: Xeroid::Objects::Address do
    type Xeroid::Objects::Address::Type::POBOX
    address_lines ['Mehringdamm 222']
    city "Berlin"
    region "Berlin"
    postal_code "10999"
    country "Deutschland"
    attention_to "J. Bloggs"
  end
end
