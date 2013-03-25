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

    it "returns nil for currency_rate by default" do
      payment.currency_rate.should be_nil
    end

    context "with currency_rate" do
      let(:currency_rate) { BigDecimal.new("1.2") }
      let(:payment) { Payment.new(invoice: invoice, account: account, amount: amount, date: date, currency_rate: currency_rate) }

      it "can return its currency_rate" do
        payment.currency_rate.should == currency_rate
      end
    end
  end
end
