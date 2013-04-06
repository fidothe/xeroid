require 'vcr_helper'
require 'xeroid'

describe "Invoices" do
  let(:credentials) { Credentials.fetch }
  let(:key) { credentials['consumer_key'] }
  let(:secret) { credentials['consumer_secret'] }
  let(:private_key_path) { File.expand_path(credentials['private_key'], ENV['HOME']) }
  let(:auth_token) { Xeroid::Auth::Private.create_token(key, secret, private_key_path) }
  let(:client) { Xeroid::Client.new(auth_token) }

  describe "fetching a single Invoice" do
  end

  describe "POSTing a new invoice" do
    let(:contact) { Xeroid::Objects::Contact.new(name: "Test Co") }
    let(:account) { Xeroid::Objects::Account.new(code: "200") }
    let(:simple_line_item) { Xeroid::Objects::LineItem.new(description: "Item", quantity: 1, unit_amount: BigDecimal.new("10.00"), account: account) }

    context "with a valid invoice" do
      it "can successfully post a minimal (implied Draft) invoice", :vcr do
        invoice = Xeroid::Objects::Invoice.new_with_line_items(contact: contact, type: Xeroid::Objects::Invoice::Type::ACCPAY) { |line_items|
          line_items << simple_line_item 
        }

        api_response = client.invoices.post_one(invoice)
        api_response.status.should == Xeroid::APIResponse::OKAY

        returned_invoice = api_response.object
        returned_invoice.id.should_not be_nil

        returned_invoice.contact.id.should_not be_nil
        returned_invoice.contact.name.should == contact.name

        returned_invoice.line_items.size.should == 1
        returned_invoice.line_items.first.description.should == simple_line_item.description
        returned_invoice.line_items.first.unit_amount.should == simple_line_item.unit_amount
      end
    end

    context "with an invalid invoice" do
      it "returns an APIException object", :vcr do
        invoice = Xeroid::Objects::Invoice.new_with_line_items(contact: contact) { |l| }

        api_response = client.invoices.post_one(invoice)

        api_response.status.should == Xeroid::APIResponse::API_EXCEPTION

        validation_errors = api_response.object
        validation_errors.errors.should_not be_empty
      end
    end
  end
end
