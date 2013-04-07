Given(/^a valid minimal draft invoice object$/) do
  @payload = FactoryGirl.build(:minimal_draft_invoice)
end

Given(/^an invalid draft invoice object$/) do
  @payload = FactoryGirl.build(:invalid_draft_invoice)
end

Given(/^several valid minimal draft invoice objects$/) do
  @payload = (0..2).collect { FactoryGirl.build(:minimal_draft_invoice) }
end

Then(/^get back an invoice object with IDs$/) do
  invoice = @api_response.object
  invoice.id.should_not be_nil
  invoice.contact.id.should_not be_nil
end

Then(/^get back invoice objects with IDs$/) do
  @api_responses.size.should == 3
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

