FactoryGirl.define do
  sequence :user_email do |n|
    "user#{n}@email.com"
  end

  factory :user do
    first_name "Jason"
    last_name "Rush"
    email { generate(:user_email) }
    password { "password" }
    password_confirmation { "password" }
  end
end