FactoryGirl.define do
  factory :comment do
    name "Jason"
    email "jasonrush@jasonrush.com"
    comment ("lorem ipsum " * 20)
    commentable { |a| a.association(:post) }
  end
end