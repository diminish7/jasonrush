FactoryGirl.define do
  sequence :blog_name do |n|
    "My Blog #{n}"
  end

  factory :blog do
    name { generate(:blog_name) }
  end
end