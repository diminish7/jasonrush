require 'spec_helper'

describe Blog do
  before do
    @blog = FactoryGirl.create(:blog)

    # Two posts in 2012, two posts in 2011
    post = FactoryGirl.create(:post, blog: @blog)
    post.update_attribute(:created_at, Time.zone.parse("2012-12-01 10:00:00"))

    post = FactoryGirl.create(:post, blog: @blog)
    post.update_attribute(:created_at, Time.zone.parse("2012-11-01 10:00:00"))

    post = FactoryGirl.create(:post, blog: @blog)
    post.update_attribute(:created_at, Time.zone.parse("2011-12-01 10:00:00"))

    post = FactoryGirl.create(:post, blog: @blog)
    post.update_attribute(:created_at, Time.zone.parse("2011-11-01 10:00:00"))

    @blog.posts(true) # Reload posts
  end

  it "should return a hash of possible years and months" do
    hash = @blog.possible_years_and_months
    hash.keys.length.should == 2
    [2012, 2011].each do |year|
      hash[year].length.should == 2
      hash[year].select { |month| month == 12 }.length.should == 1
      hash[year].select { |month| month == 11 }.length.should == 1
    end
  end
end