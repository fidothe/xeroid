require 'spec_helper'

require 'xeroid/objects/account'

module Xeroid::Objects
  describe Account do
    let(:account) { Account.new(code: "NWBC") }

    it "can return its code" do
      account.code.should == "NWBC"
    end
  end
end
