require 'spec_helper'

describe Blog do
  subject {
    FactoryGirl.create(:blog).tap do |blog|
      post = FactoryGirl.create(:post, blog: blog)
      post.update_attribute(:created_at, Time.zone.parse("2012-12-01 10:00:00"))

      post = FactoryGirl.create(:post, blog: blog)
      post.update_attribute(:created_at, Time.zone.parse("2012-11-01 10:00:00"))

      post = FactoryGirl.create(:post, blog: blog)
      post.update_attribute(:created_at, Time.zone.parse("2011-12-01 10:00:00"))

      post = FactoryGirl.create(:post, blog: blog)
      post.update_attribute(:created_at, Time.zone.parse("2011-11-01 10:00:00"))

      blog.posts(true)
    end
  }

  it "returns a hash of possible months" do
    months = subject.possible_months

    months.should have(4).months

    [2012, 2011].each do |year|
      [11, 12].each do |month|
        expect(months.detect { |m| m['month'] == month && m['year'] == year }).to be_present
      end
    end
  end
end