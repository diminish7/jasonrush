FactoryGirl.define do
  sequence :post_title do |n|
    "My Blog Post #{n}"
  end

  factory :post do
    title { generate(:post_title) }
    body "Lorem Ipsum Blah Blah"
    author { |a| a.association(:user) }
    association(:blog)
  end
end