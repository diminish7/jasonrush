require 'spec_helper'

describe Post do
  it "should validate the presence of title, body and author" do
    @post = FactoryGirl.create(:post)
    [:title, :body, :author].each do |getter|
      setter = "#{getter}="
      @post.send(setter, nil)
      @post.should_not be_valid
      @post.errors[getter].include?("can't be blank").should be_true
    end
  end

  it "saves the summary automatically" do
    first_paragraph = "<p>first</p>"
    second_paragraph = "<p>second</p>"
    @post = FactoryGirl.create(:post, body: first_paragraph + second_paragraph)
    @post.summary.should eq first_paragraph
  end

  describe "named scopes" do

    it "should return all the posts for a year" do
      current_year = Time.zone.now.year
      posts = (0..2).collect do |i|
        post = FactoryGirl.create(:post)
        post.update_attribute(:created_at, Time.zone.now-i.years)
      end
      current = Post.for_year(current_year)
      current.count.should == 1
      current.first.created_at.year.should == current_year
      last_year = Post.for_year(current_year-1)
      last_year.count.should == 1
      last_year.first.created_at.year.should == current_year-1
      previous_year = Post.for_year(current_year-2)
      previous_year.count.should == 1
      previous_year.first.created_at.year.should == current_year-2
    end
  end

  describe "permissions" do
    it "should return false from can_edit? unless the user can edit" do
      post = FactoryGirl.create :post
      user = FactoryGirl.create :user
      post.can_edit?(user).should be_false
      post.can_edit?(post.author).should be_true
    end
  end

end
