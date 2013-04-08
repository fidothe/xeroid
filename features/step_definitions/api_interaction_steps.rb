When(/^I post it to Xero$/) do
  credentials = Credentials.fetch
  private_key_path = File.expand_path(credentials['private_key'], ENV['HOME'])
  auth_token = Xeroid::Auth::Private.create_token(credentials['consumer_key'], credentials['consumer_secret'], private_key_path)
  client = Xeroid::Client.new(auth_token)

  @api_response = client.invoices.post_one(@payload.first)
end

Then(/^I should get confirmation it was posted successfully$/) do
  @api_response.status.should == Xeroid::APIResponse::OKAY
end

When(/^I post them to Xero$/) do
  credentials = Credentials.fetch
  private_key_path = File.expand_path(credentials['private_key'], ENV['HOME'])
  auth_token = Xeroid::Auth::Private.create_token(credentials['consumer_key'], credentials['consumer_secret'], private_key_path)
  client = Xeroid::Client.new(auth_token)

  @api_responses = client.invoices.post_many(@payload)
end

Then(/^I should get confirmation they were posted successfully$/) do
  @api_responses.all? { |r| r.status == Xeroid::APIResponse::OKAY }.should be_true
end

Then(/^I should get confirmation that the valid invoices were posted successfully$/) do
  @api_responses.select { |r| r.status == Xeroid::APIResponse::OKAY }.size.should == @valid_payload_objects
end

Then(/^confirmation that the invalid invoice caused a problem$/) do
  @api_responses.reject { |r| r.status == Xeroid::APIResponse::OKAY }.size.should == @invalid_payload_objects
end
