require 'spec_helper'

describe BlogPolicy do
  let(:blog) { FactoryGirl.create(:blog) }
  let(:user) { FactoryGirl.create(:user) }

  subject { BlogPolicy.new(user, blog) }

  it "is always read-only" do
    expect(subject.index?).to be_true
    expect(subject.show?).to be_true
    expect(subject.create?).to be_false
    expect(subject.new?).to be_false
    expect(subject.update?).to be_false
    expect(subject.edit?).to be_false
    expect(subject.destroy?).to be_false
  end
end