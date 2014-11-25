require 'spec_helper'

describe PostPolicy do
  let(:author) { FactoryGirl.create(:user) }
  let(:other_author) { FactoryGirl.create(:user) }
  let(:post) { FactoryGirl.create(:post, author: author) }

  context "with the post's author" do
    subject { PostPolicy.new(author, post) }

    it "allows all access" do
      expect(subject.index?).to be_true
      expect(subject.show?).to be_true
      expect(subject.new?).to be_true
      expect(subject.create?).to be_true
      expect(subject.edit?).to be_true
      expect(subject.update?).to be_true
      expect(subject.destroy?).to be_true
    end
  end

  context "with another author" do
    subject { PostPolicy.new(other_author, post) }

    it "allows reads" do
      expect(subject.index?).to be_true
      expect(subject.show?).to be_true
    end

    it "allows creation" do
      expect(subject.new?).to be_true
      expect(subject.create?).to be_true
    end

    it "does not allow writes" do
      expect(subject.edit?).to be_false
      expect(subject.update?).to be_false
      expect(subject.destroy?).to be_false
    end
  end
end
