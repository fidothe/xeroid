FactoryGirl.define do
  initialize_with { new(attributes) }

  factory :minimal_draft_contact, class: Xeroid::Objects::Contact do
    name "Test Company"
  end
end
