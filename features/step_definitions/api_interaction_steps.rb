module EndpointLookup
  def self.lookup_endpoint(payload_object)
    case payload_object
    when Xeroid::Objects::Invoice
      :invoices
    when Xeroid::Objects::Contact
      :contacts
    end
  end

  def self.get_endpoint(payload_object)
    client = CreateClient.create
    client.send(lookup_endpoint(payload_object))
  end
end

module CreateClient
  def self.create
    credentials = Credentials.fetch
    private_key_path = File.expand_path(credentials['private_key'], ENV['HOME'])
    auth_token = Xeroid::Auth::Private.create_token(credentials['consumer_key'], credentials['consumer_secret'], private_key_path)
    Xeroid::Client.new(auth_token)
  end
end

When(/^I fetch all tax rates from Xero$/) do
  @api_responses = CreateClient.create.tax_rates.all
end

When(/^I post it to Xero$/) do
  @api_response = EndpointLookup.get_endpoint(@payload.first).post_one(@payload.first)
end

When(/^I post them to Xero$/) do
  @api_responses = EndpointLookup.get_endpoint(@payload.first).post_many(@payload)
end

Then(/^I should get confirmation it was posted successfully$/) do
  @api_response.status.should == Xeroid::APIResponse::OKAY
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
