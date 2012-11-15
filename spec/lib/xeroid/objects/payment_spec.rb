require 'spec_helper'
require 'bigdecimal'

require 'xeroid/objects/invoice'
require 'xeroid/objects/account'
require 'xeroid/objects/payment'

module Xeroid::Objects
  describe Payment do
    let(:invoice) { Invoice.new(id: "abcde-12345-abcde-12345") }
    let(:account) { Account.new(code: "NWBC") }
    let(:amount) { BigDecimal.new("10.00") }
    let(:date) { Date.parse("2012-11-15") }
    let(:payment) { Payment.new(invoice: invoice, account: account, amount: amount, date: date) }

    it "can return its invoice" do
      payment.invoice.should == invoice
    end

    it "can return its account" do
      payment.account.should == account
    end

    it "can return its date" do
      payment.date.should == date
    end

    it "can return its amount" do
      payment.amount.should == amount
    end
  end
end
