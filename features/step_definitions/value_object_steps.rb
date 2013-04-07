Given(/^a valid minimal draft invoice object$/) do
  @invoice = FactoryGirl.build(:minimal_draft_invoice)
end

Given(/^an invalid draft invoice object$/) do
  @invoice = FactoryGirl.build(:invalid_draft_invoice)
end

When(/^I post it to Xero$/) do
  credentials = Credentials.fetch
  private_key_path = File.expand_path(credentials['private_key'], ENV['HOME'])
  auth_token = Xeroid::Auth::Private.create_token(credentials['consumer_key'], credentials['consumer_secret'], private_key_path)
  client = Xeroid::Client.new(auth_token)

  @api_response = client.invoices.post_one(@invoice)
  @returned_invoice = @api_response.object
end

Then(/^I should get confirmation it was posted successfully$/) do
  @api_response.status.should == Xeroid::APIResponse::OKAY
end

Then(/^get back an invoice object with IDs$/) do
  @returned_invoice.id.should_not be_nil
  @returned_invoice.contact.id.should_not be_nil
end

Then(/^I should get an API exception object back$/) do
  @api_response.status.should == Xeroid::APIResponse::API_EXCEPTION

  validation_errors = @api_response.object
  validation_errors.errors.should_not be_empty
end

