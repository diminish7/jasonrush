require 'spec_helper'

describe User do
  subject { FactoryGirl.build(:user) }

  describe "#full_name" do
    it "should combine the first and last name" do
      subject.full_name.should == "Jason Rush"
    end
  end
end
