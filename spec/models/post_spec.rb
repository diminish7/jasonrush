require 'spec_helper'

describe Post do
  subject { FactoryGirl.create(:post) }

  it "validates presence of title, body and author" do
    [:title, :body, :author].each do |getter|
      setter = "#{getter}="
      subject.send(setter, nil)
      subject.should_not be_valid
      expect(subject.errors[getter]).to include("can't be blank")
    end
  end

  it "saves the summary automatically" do
    first_paragraph = "<p>first</p>"
    second_paragraph = "<p>second</p>"
    subject.update_attributes(body: first_paragraph + second_paragraph)
    expect(subject.summary).to eq first_paragraph
  end

  describe "#for_year" do
    let!(:this_year_post) { FactoryGirl.create(:post).tap { |p| p.update_attribute(:created_at, Time.zone.now) } }
    let!(:last_year_post) { FactoryGirl.create(:post).tap { |p| p.update_attribute(:created_at, Time.zone.now-1.year) } }
    let!(:previous_year_post) { FactoryGirl.create(:post).tap { |p| p.update_attribute(:created_at, Time.zone.now-2.years) } }

    it "returns all the posts for a year" do
      current_year = Time.zone.now.year
      current_year_posts = Post.for_year(current_year)
      expect(current_year_posts).to have(1).post
      expect(current_year_posts).to include(this_year_post)

      last_year_posts = Post.for_year(current_year-1)
      expect(last_year_posts).to have(1).post
      expect(last_year_posts).to include(last_year_post)

      previous_year_posts = Post.for_year(current_year-2)
      expect(previous_year_posts).to have(1).post
      expect(previous_year_posts).to include(previous_year_post)
    end
  end
end
