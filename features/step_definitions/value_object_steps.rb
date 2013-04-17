Given(/^a valid minimal draft invoice object$/) do
  @valid_payload_objects = 1
  (@payload ||= []) << FactoryGirl.build(:minimal_draft_invoice)
end

Given(/^an invalid draft invoice object$/) do
  @invalid_payload_objects = 1
  (@payload ||= []) << FactoryGirl.build(:invalid_draft_invoice)
end

Given(/^several valid minimal draft invoice objects$/) do
  @valid_payload_objects = 3
  (@payload ||= []).concat((0..2).collect { FactoryGirl.build(:minimal_draft_invoice) })
end

Given(/^a valid contact object$/) do
  @valid_payload_objects = 1
  (@payload ||= []) << FactoryGirl.build(:valid_contact)
end

Then(/^get back a contact object with ID$/) do
  contact = @api_response.object
  contact.id.should_not be_nil
end

Then(/^get back an invoice object with IDs$/) do
  invoice = @api_response.object
  invoice.id.should_not be_nil
  invoice.contact.id.should_not be_nil
end

Then(/^get back invoice objects with IDs$/) do
  @api_responses.size.should == @valid_payload_objects
  invoices = @api_responses.collect { |response| response.object }
  invoices.each do |invoice|
    invoice.id.should_not be_nil
    invoice.contact.id.should_not be_nil
  end
  # Each invoice ID should be different
  invoices.collect { |i| i.id }.uniq.size.should == 3
  # Each contact ID should be the same
  invoices.collect { |i| i.contact.id }.uniq.size.should == 1
end

Then(/^I should get an API exception object back$/) do
  @api_response.status.should == Xeroid::APIResponse::API_EXCEPTION

  @api_response.object.errors.should_not be_empty
end

Then(/^get back invoice objects with IDs for the valid invoices$/) do
  invoices = @api_responses.select { |response| response.okay? }.collect { |response| response.object }
  invoices.size.should == @valid_payload_objects
  invoices.each do |invoice|
    invoice.id.should_not be_nil
    invoice.contact.id.should_not be_nil
  end
  # Each invoice ID should be different
  invoices.collect { |i| i.id }.uniq.size.should == 3
  # Each contact ID should be the same
  invoices.collect { |i| i.contact.id }.uniq.size.should == 1
end

Then(/^an API exception object for the invalid invoice$/) do
  exceptions = @api_responses.reject { |response| response.okay? }.collect { |response| response.object }
  exceptions.size.should == @invalid_payload_objects
  exceptions.each do |exception|
    exception.errors.should_not be_empty
  end
end

Then(/^I should get back valid tax rate objects$/) do
  tax_rates = @api_responses.select { |response| response.okay? }.collect { |response| response.object }
  tax_rates.size.should > 0
end
