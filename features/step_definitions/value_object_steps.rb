Given(/^a valid minimal draft invoice object$/) do
  @contact = Xeroid::Objects::Contact.new(name: "Test Co")
  @account = Xeroid::Objects::Account.new(code: "200")
  @simple_line_item = Xeroid::Objects::LineItem.new(description: "Item", quantity: 1, unit_amount: BigDecimal.new("10.00"), account: @account)

  @invoice = Xeroid::Objects::Invoice.new_with_line_items(contact: @contact, type: Xeroid::Objects::Invoice::Type::ACCPAY) { |line_items|
    line_items << @simple_line_item 
  }
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
